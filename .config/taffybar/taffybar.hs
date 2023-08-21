{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Default (def)
import System.Taffybar
import System.Taffybar.Context (TaffybarConfig(..))
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget
import System.Taffybar.Widget.Generic.PollingGraph


main = startTaffybar exampleTaffybarConfig

transparent, yellow1, yellow2, green1, green2, taffyBlue
    :: (Double, Double, Double, Double)
transparent = (0.0, 0.0, 0.0, 0.0)
yellow1 = (0.9453125, 0.63671875, 0.2109375, 1.0)
yellow2 = (0.9921875, 0.796875, 0.32421875, 1.0)
green1 = (0, 1, 0, 1)
green2 = (1, 0, 1, 0.5)
taffyBlue = (0.129, 0.588, 0.953, 1)

myGraphConfig, netCfg, memCfg, cpuCfg :: GraphConfig
myGraphConfig = def
    { graphPadding = 0
    , graphBorderWidth = 0
    , graphWidth = 75
    , graphBackgroundColor = transparent
    }

netCfg = myGraphConfig
    { graphDataColors = [yellow1, yellow2]
    , graphLabel = Just "net"
    }

memCfg = myGraphConfig
    { graphDataColors = [taffyBlue]
    , graphLabel = Just "mem"
    }

cpuCfg = myGraphConfig
    { graphDataColors = [green1, green2]
    , graphLabel = Just "cpu"
    }

memCallback :: IO [Double]
memCallback = do
    mi <- parseMeminfo
    pure [memoryUsedRatio mi]

cpuCallback :: IO [Double]
cpuCallback = do
    (_, systemLoad, totalLoad) <- cpuLoad
    pure [totalLoad, systemLoad]

exampleTaffybarConfig :: TaffybarConfig
exampleTaffybarConfig =
    let myWorkspacesConfig = def
            { minIcons = 1
            , widgetGap = 5
            , showWorkspaceFn = hideEmpty
            }
        workspaces = workspacesNew myWorkspacesConfig
        cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
        mem = pollingGraphNew memCfg 1 memCallback
        net = networkGraphNew netCfg Nothing
        clock = textClockNewWith def { clockFormatString = "%a %e %b %H:%M:%S"}
        layout = layoutNew def
        windowsW = windowsNew def
        -- See https://github.com/taffybar/gtk-sni-tray#statusnotifierwatcher
        -- for a better way to set up the sni tray
        tray = sniTrayNew
        myConfig = def
            { startWidgets =
                [ workspaces
                , layout >>= buildContentsBox
                ]
            , centerWidgets = [ windowsW >>= buildContentsBox ]
            , endWidgets = map (>>= buildContentsBox)
                [ tray
                , clock
                , cpu
                , mem
                , net
                , mpris2New
                ]
            , barPosition = Bottom
            , barPadding = 0
            , barHeight = ExactSize 32
            , widgetSpacing = 0
            }
    in withLogServer $ withToggleServer $ toTaffyConfig myConfig

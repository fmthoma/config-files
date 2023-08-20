{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.TaffybarPagerHints
import XMonad.Layout.Accordion
import XMonad.Layout.CenteredIfSingle
import XMonad.Layout.IfMax
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Magnifier hiding (Toggle)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed as Tabbed
import XMonad.Layout.TallMastersCombo hiding (ws1, ws2, (|||))
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.Ungrab
import XMonad.Util.WorkspaceCompare
import qualified XMonad.StackSet as W
import qualified XMonad.Util.Rectangle as R

import qualified Data.Map as M
import Data.Maybe (isJust)
import Data.List (partition)


main :: IO ()
main = xmonad $ foldr (.) id mods layoutsConfig

layoutsConfig = def { layoutHook = avoidStruts $ smartBorders $ fullscreen $ mkToggle (single NBFULL) (tiled1 ||| tiled2 ||| edge 15 tabbed) }
    where
    tiled2 = spacing 5 $ edge 10 $ magnifiercz' 1.5 $ Tall nmaster delta ratio

    tiled1 = edge 10 $ tmsCombineTwo True nmaster delta ratio (spacing 5 $ Tall 0 0 0)
        $ tmsCombineTwo False 1 delta (1/2)
            (edge 5 Simplest)
            (edge 5 tabbed)

    tabbed = Tabbed.tabbed shrinkText solarized
    edge px    = ModifiedLayout (Spacing False (Border px px px px) True (Border 0 0 0 0) True)
    spacing px = ModifiedLayout (Spacing False (Border 0 0 0 0) True (Border px px px px) True)
    nmaster = 1
    ratio = 2/3
    delta = 3/100

mods :: [XConfig a -> XConfig a]
mods =
    [ docks
    , ewmhFullscreen
    , ewmh
    , pagerHints
    , superKeyConfig
    , terminalConfig
    , stylingConfig
    , keymapConfig
    , workspacesConfig
    , hooksConfig
    ]

superKeyConfig :: XConfig a -> XConfig a
superKeyConfig cfg = cfg { modMask = mod4Mask }

terminalConfig :: XConfig a -> XConfig a
terminalConfig cfg = cfg { terminal = "urxvt" }

stylingConfig :: XConfig a -> XConfig a
stylingConfig cfg = cfg
    { borderWidth = 3
    , normalBorderColor = base02
    , focusedBorderColor = green
    , focusFollowsMouse = False
    }

hooksConfig :: XConfig a -> XConfig a
hooksConfig cfg = addEwmhWorkspaceSort (pure $ filterOutWs ["NSP"]) cfg { manageHook }
  where
    manageHook = composeAll
        [ insertPosition Below Older
        , namedScratchpadManageHook scratchpads
        ]

keymapConfig :: XConfig a -> XConfig a
keymapConfig cfg = cfg { keys = keymap <> keys cfg }
  where
    keymap conf@XConfig { modMask } = M.fromList
        [ ((noModMask,                  xK_F1),     windows (W.greedyView ws1))
        , ((noModMask,                  xK_F2),     windows (W.greedyView ws2))
        , ((noModMask,                  xK_F3),     windows (W.greedyView ws3))
        , ((noModMask,                  xK_F4),     windows (W.greedyView ws4))
        , ((modMask,                    xK_F1),     windows (W.greedyView ws1 . W.shift ws1))
        , ((modMask,                    xK_F2),     windows (W.greedyView ws2 . W.shift ws2))
        , ((modMask,                    xK_F3),     windows (W.greedyView ws3 . W.shift ws3))
        , ((modMask,                    xK_F4),     windows (W.greedyView ws4 . W.shift ws4))
        , ((modMask .|. controlMask,    xK_F1),     windows (W.shift ws1))
        , ((modMask .|. controlMask,    xK_F2),     windows (W.shift ws2))
        , ((modMask .|. controlMask,    xK_F3),     windows (W.shift ws3))
        , ((modMask .|. controlMask,    xK_F4),     windows (W.shift ws4))
        , ((modMask,                    xK_d),      kill)
        , ((modMask,                    xK_Up),     windows W.focusUp)
        , ((modMask,                    xK_Down),   windows W.focusDown)
        , ((modMask .|. controlMask,    xK_k),      windows W.swapUp)
        , ((modMask .|. controlMask,    xK_j),      windows W.swapDown)
        , ((modMask .|. controlMask,    xK_Up),     windows W.swapUp)
        , ((modMask .|. controlMask,    xK_Down),   windows W.swapDown)
        , ((modMask,                    xK_Tab),    sendMessage NextLayout)
        , ((modMask,                    xK_space),  namedScratchpadAction scratchpads "scratchpad")
        , ((modMask,                    xK_Return), spawn "dmenu_hist_run")
        , ((modMask,                    xK_f),      withFocused $ \w -> (broadcastMessage (ToggleFullscreen w) >> sendMessage FullscreenChanged))
        , ((modMask .|. shiftMask,      xK_f),      withFocused $ \w -> windows (W.float w (W.RationalRect 0.2 0.2 0.6 0.6) ))
        ]

workspacesConfig :: XConfig a -> XConfig a
workspacesConfig cfg = cfg { workspaces = [ws1, ws2, ws3, ws4] }

ws1, ws2, ws3, ws4 :: WorkspaceId
ws1 = "1"
ws2 = "2"
ws3 = "3"
ws4 = "4"

scratchpads :: NamedScratchpads
scratchpads =
    [ NS "scratchpad" "urxvt -name scratchpad" (resource =? "scratchpad") (customFloating (W.RationalRect 0.45 0.45 0.5 0.5)) ]

solarized :: Theme
solarized = def
    { activeColor = green
    , activeBorderColor = green
    , activeBorderWidth = 3
    , activeTextColor = base02
    , inactiveColor = base02
    , inactiveBorderColor = base02
    , inactiveBorderWidth = 3
    , inactiveTextColor = base01
    , urgentColor = orange
    , urgentBorderColor = orange
    , urgentBorderWidth = 3
    , urgentTextColor = base03
    , decoHeight = 24
    }

base03, base02, base01, base00, base0, base1, base2, base3 :: String
base03 = "#002b36"
base02 = "#073642"
base01 = "#586e75"
base00 = "#657b83"
base0  = "#839496"
base1  = "#93a1a1"
base2  = "#eee8d5"
base3  = "#fdf6e3"

yellow, orange, red, magenta, violet, blue, cyan, green :: String
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

data Fullscreen a = Fullscreen (M.Map a (Maybe W.RationalRect, Bool))
    deriving (Read, Show)

data FullscreenMessage = ToggleFullscreen Window | FullscreenChanged

instance Message FullscreenMessage

instance LayoutModifier Fullscreen Window where
    handleMess ff@(Fullscreen fulls) m = case fromMessage m of
        Just (ToggleFullscreen win) -> case M.lookup win fulls of
            Just (Just frect, True) -> pure $ Just $ Fullscreen $ M.adjust (\(a, b) -> (a, False)) win fulls
            Just _                  -> pure $ Just $ Fullscreen $ M.delete win fulls
            Nothing -> do
                maybeFloatingRect <- M.lookup win . W.floating <$> gets windowset
                pure $ Just $ Fullscreen $ M.insert win (maybeFloatingRect, True) fulls
        Just FullscreenChanged -> do
            st@XState { windowset = ws } <- get
            let floatingFulls = M.filter (isJust . fst) fulls
                flt = W.floating ws
                flt' = M.intersectionWith doFull floatingFulls flt
                  where
                    doFull (Just rect, False) _ = rect
                    doFull _                  _ = frect
                    frect = W.RationalRect 0 0 1 1
            put st { windowset = ws { W.floating = M.union flt' flt } }
            pure $ Just $ Fullscreen $ M.filter snd fulls
        _ -> pure Nothing

    pureModifier (Fullscreen fulls) rect _ list = (visfulls' ++ rest', Nothing)
      where
        (visfulls, rest) = partition ((`M.member` fulls) . fst) list
        visfulls' = map (\(w, _) -> (w, rect)) visfulls
        rest' = if null visfulls'
            then rest
            else filter (not . R.supersetOf rect . snd) rest

fullscreen :: LayoutClass l a => l a -> ModifiedLayout Fullscreen l a
fullscreen = ModifiedLayout $ Fullscreen M.empty

{-# LANGUAGE NamedFieldPuns #-}
import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Layout.Accordion
import XMonad.Layout.CenteredIfSingle
import XMonad.Layout.Tabbed
import qualified XMonad.StackSet as W
import qualified Data.Map as M

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ myConfig

myConfig = def
    { modMask = mod4Mask
    , workspaces = [ws1, ws2, ws3, ws4]
    , layoutHook
    , terminal = "urxvt"
    , borderWidth = 3
    , normalBorderColor = "#073642"
    , focusedBorderColor = "#859900"
    , focusFollowsMouse = False
    , keys = keymap <> keys def
    , manageHook = composeAll
        [ insertPosition Below Older ]
    }
  where
    modMask = mod4Mask
    layoutHook = tiled ||| Mirror tiled ||| simpleTabbed ||| Full
      where
        tiled = magnifiercz' 1.5 $ Tall nmaster delta ratio
        nmaster = 1
        ratio = 2/3
        delta = 3/100

keymap :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
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
    ]

ws1, ws2, ws3, ws4 :: WorkspaceId
ws1 = "1"
ws2 = "2"
ws3 = "3"
ws4 = "4"

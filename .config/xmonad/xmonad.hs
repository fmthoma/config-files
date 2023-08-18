{-# LANGUAGE NamedFieldPuns #-}
import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ myConfig

myConfig = def
    { modMask = mod4Mask
    , layoutHook
    , borderWidth = 3
    , normalBorderColor = "#073642"
    , focusedBorderColor = "#859900"
    , manageHook = composeAll
        [ insertPosition Below Older ]
    } `additionalKeysP` keymap
  where
    modMask = mod4Mask
    layoutHook = tiled ||| Mirror tiled ||| simpleTabbed ||| Full
      where
        tiled = magnifiercz' 1.5 $ Tall nmaster delta ratio
        nmaster = 1
        ratio = 2/3
        delta = 3/100

keymap =
    [ ("M-<Return>", spawn "i3-dmenu-hist-desktop")
    ]

{-# LANGUAGE NamedFieldPuns #-}
import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.Magnifier

main :: IO ()
main = xmonad myConfig

myConfig = def { modMask, layoutHook } `additionalKeysP` keymap
  where
    modMask = mod4Mask
    layoutHook = tiled ||| Mirror tiled ||| Full
      where
        tiled = magnifiercz' 1.5 $ Tall nmaster delta ratio
        nmaster = 1
        ratio = 2/3
        delta = 3/100

keymap =
    [ ("M-<Return>", spawn "i3-dmenu-hist-desktop")
    ]

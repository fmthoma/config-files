{-# LANGUAGE RecordWildCards #-}
import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad def {..} `additionalKeysP` keymap

modMask = mod4Mask

layoutHook = tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 2/3
    delta = 3/100

keymap =
    [ ("M-<Return>", spawn "i3-dmenu-hist-desktop")
    ]

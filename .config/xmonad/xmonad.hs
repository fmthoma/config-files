{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Focus
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Place
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.TaffybarPagerHints
import XMonad.Layout.Accordion
import XMonad.Layout.CenteredIfSingle
import XMonad.Layout.IfMax
import XMonad.Layout.IndependentScreens
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
import Data.Maybe (isJust, fromMaybe)
import Data.List (find, partition)
import System.Exit (exitSuccess)


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
    , terminalConfig
    , stylingConfig
    , keymapConfig
    , workspacesConfig
    , hooksConfig
    ]

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
        [ insertPosition Below Newer
        , namedScratchpadManageHook scratchpads
        , className =? "feh" --> placeHook (fixed (0.5, 0.5)) <> doFloat
        , className =? "firefox" --> doShift ws3
        ]

keymapConfig :: XConfig a -> XConfig a
keymapConfig cfg = cfg { keys = keymap <> keys cfg, modMask = modMask }
  where
    keymap conf@XConfig { modMask } = M.fromList (workspaceBindings ++ otherBindings)
    modMask = mod4Mask
    workspaceBindings = concat $ zipWith3
        (\ws fkey nkey ->
            [ ((noModMask,                               fkey), windows (withWorkspaceInstanceOnScreen W.view ws))
            , ((modMask,                                 fkey), windows (withWorkspaceInstanceOnScreen W.view ws . withWorkspaceInstanceOnScreen W.shift ws))
            , ((modMask .|. controlMask,                 fkey), windows (withWorkspaceInstanceOnScreen W.shift ws))
            , ((modMask,                                 nkey), windows (withWorkspaceInstanceOnScreen W.view ws))
            , ((modMask .|. controlMask,                 nkey), windows (withWorkspaceInstanceOnScreen W.view ws . withWorkspaceInstanceOnScreen W.shift ws))
            , ((modMask .|. controlMask .|. shiftMask,   nkey), windows (withWorkspaceInstanceOnScreen W.shift ws))
            ])
        [ws1, ws2, ws3, ws4]
        [xK_F1 .. xK_F4]
        [xK_1 .. xK_4]
    otherBindings =
        [ ((modMask,                                xK_d),      kill)
        , ((modMask,                                xK_Up),     windows W.focusUp)
        , ((modMask,                                xK_Down),   windows W.focusDown)
        , ((modMask .|. controlMask,                xK_k),      windows W.swapUp)
        , ((modMask .|. controlMask,                xK_j),      windows W.swapDown)
        , ((modMask .|. controlMask,                xK_Up),     windows W.swapUp)
        , ((modMask .|. controlMask,                xK_Down),   windows W.swapDown)
        , ((modMask .|. controlMask .|. shiftMask,  xK_Up),     shiftCurrentWorkspaceInstanceToScreen (+1))
        , ((modMask .|. controlMask .|. shiftMask,  xK_Down),   shiftCurrentWorkspaceInstanceToScreen (subtract 1))
        , ((modMask,                                xK_Tab),    sendMessage NextLayout)
        , ((modMask,                                xK_space),  namedScratchpadAction scratchpads "scratchpad")
        , ((modMask,                                xK_Return), spawn "rofi-menu")
        , ((modMask,                                xK_f),      withFocused $ \w -> (broadcastMessage (ToggleFullscreen w) >> sendMessage FullscreenChanged))
        , ((modMask .|. controlMask,                xK_f),      withFocused toggleFloat)
        , ((modMask,                                xK_r),      spawn "rofi -show emoji")
        , ((modMask,                                xK_n),      spawn "feh -B '#002b36' $HOME/.i3/neo{1..6}.png")
        , ((noModMask,                              xK_Print),  spawn "scrot -e 'xclip -selection clipboard -t image/png $f'")
        , ((controlMask,                            xK_Print),  spawn "sleep 0.1; scrot -s -e 'xclip -selection clipboard -t image/png $f'")
        , ((modMask .|. controlMask,                xK_r),      spawn "xmonad --recompile && xmonad --restart")
        , ((modMask .|. controlMask,                xK_q),      io exitSuccess)
        ]
    toggleFloat w = windows $ \s -> if w `M.member` W.floating s
        then W.sink w s
        else W.float w (W.RationalRect 0.2 0.2 0.6 0.6) s

withWorkspaceInstanceOnScreen :: (PhysicalWorkspace -> WindowSet -> a) -> VirtualWorkspace -> WindowSet -> a
withWorkspaceInstanceOnScreen f vws ws =
    let pwss = filter ((== vws) . snd . unmarshall . W.tag) $ W.workspaces ws
        currentScreenId = W.screen $ W.current ws
        pws = fromMaybe
            (marshall currentScreenId vws)
            (W.tag <$> find (isJust . W.stack) pwss)
        (screenId, _) = unmarshall pws
    in f pws (focusScreen screenId ws)

shiftCurrentWorkspaceInstanceToScreen :: (ScreenId -> ScreenId) -> X ()
shiftCurrentWorkspaceInstanceToScreen screenInc = do
    nScreens <- countScreens
    windows $ \ws ->
        let (currentScreenId, currentWsp) = unmarshall (W.currentTag ws)
            newScreenId = (screenInc currentScreenId + nScreens) `mod` nScreens
            ws' = modifyCurrentStack (const Nothing) ws
            ws'' = onCurrentScreen W.view currentWsp $ focusScreen newScreenId ws'
            ws''' = modifyCurrentStack (const (W.stack $ W.workspace $ W.current ws)) ws''
            -- TODO: The stack should be empty, but if it isn't, then we would lose windows. So we should conservatively merge stacks.
        in ws'''
  where
    modifyCurrentStack f ws = 
        let current = W.current ws
            workspace = W.workspace current
            stack = W.stack workspace
        in ws { W.current = current { W.workspace = workspace { W.stack = f stack } } }

workspacesConfig :: XConfig a -> XConfig a
workspacesConfig cfg = cfg { workspaces = withScreens 3 [ws1, ws2, ws3, ws4] }

ws1, ws2, ws3, ws4 :: WorkspaceId
ws1 = "\62075"
ws2 = "\61729"
ws3 = "\62057"
ws4 = "\61728"

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

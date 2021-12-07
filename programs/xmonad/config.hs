import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)

-- for making dialog windows float
import XMonad.Hooks.ManageHelpers

-- for window spacing
import XMonad.Layout.Spacing

-- xmobar
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops

main :: IO ()
main = xmonad . ewmh =<< xmobar myConfig

myConfig = def
  { terminal    = myTerminal 
  , modMask     = mod4Mask -- Rebind Mod to the Super key
  , borderWidth = myBorderWidth
  , focusedBorderColor = "#ef8230"
  -- Bool|smartBorder Border|screenBorder Bool|screenBorderEnabled Border|windowBorder
  , layoutHook = spacingRaw False (Border 10 10 10 10) True (Border 10 10 10 10) True $
                 layoutHook def
  , manageHook = myManageHook
  }
  `additionalKeysP`
  [ ("M-p", spawn appLauncher)
  , ("M-[", spawn "firefox")
  , ("M-]", runInTerm "" "ranger")
  , ("M-/", spawn "feh --bg-fill --randomize /home/mats/.config/wallpapers/*.jpg")
  , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 5%-")
  , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 5%+")
  , ("<XF86AudioMute>",        spawn "amixer set Master toggle")
  ]

myTerminal = "alacritty" 
myBorderWidth = 2
appLauncher = "rofi -modi drun,ssh,window,emoji -show drun -show-icons -theme gruvbox-dark"

myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "jetbrains-idea-ce" <&&> name =? "win0" --> doFloat -- IntelliJ splash screen
  , className =? "jetbrains-studio"  <&&> name =? "win0" --> doFloat -- Android studio splash screen
  , isDialog                                             --> doFloat
  ] where name = stringProperty "WM_NAME"

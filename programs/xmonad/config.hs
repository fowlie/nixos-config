import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)

-- for making dialog windows float
import XMonad.Hooks.ManageHelpers

-- for window spacing
import XMonad.Layout.Spacing

main :: IO ()
main = xmonad $ def
  { terminal    = myTerminal 
  , borderWidth = myBorderWidth
  -- Bool|smartBorder Border|screenBorder Bool|screenBorderEnabled Border|windowBorder
  , layoutHook = spacingRaw False (Border 0 10 10 10) True (Border 10 10 10 10) True $
                 layoutHook def
  , manageHook = myManageHook
  }
  `additionalKeysP`
  [ ("M-p", spawn appLauncher)
  , ("M-[", spawn "firefox")
  , ("M-]", runInTerm "" "ranger")
  ]

myTerminal = "alacritty" 
myBorderWidth = 3
appLauncher = "rofi -modi drun,ssh,window,emoji -show drun -show-icons -theme gruvbox-dark"

myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "jetbrains-idea-ce" <&&> name =? "win0" --> doFloat
  , isDialog                                             --> doFloat
  ] where name = stringProperty "WM_NAME"

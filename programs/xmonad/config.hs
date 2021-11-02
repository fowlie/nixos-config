import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)

main :: IO ()
main = xmonad $ def
  { terminal    = myTerminal 
  , borderWidth = myBorderWidth
  }
  `additionalKeysP`
  [ ("M-p", spawn appLauncher)
  , ("M-[", spawn "firefox")
  , ("M-]", runInTerm "" "ranger")
  ]

myTerminal = "alacritty" 
myBorderWidth = 3
appLauncher = "rofi -modi drun,ssh,window,emoji -show drun -show-icons -theme gruvbox-dark"

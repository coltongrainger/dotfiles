import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , keys = keys defaultConfig `mappend`
          \c -> fromList [
              ((0, xK_F6), lowerVolume 4 >> return ()),
              ((0, xK_F7), raiseVolume 4 >> return ()) ]
        , handleEventHook = mconcat [ 
              docksEventHook, 
              handleEventHook defaultConfig ]
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        =}=
        }

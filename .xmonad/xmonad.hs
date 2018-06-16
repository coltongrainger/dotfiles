module Main (main) where

import System.Exit
import XMonad

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)

import XMonad.Actions.Warp         -- (18) warp the mouse pointer
import XMonad.Actions.Submap       -- (19) create keybinding submaps
import XMonad.Actions.Search hiding (Query, images) 
                                   -- (20) some predefined web searches
import XMonad.Actions.WithAll      -- (22) do something with all windows on a workspace
import XMonad.Actions.WindowGo

import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.Input
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell

import XMonad.Util.EZConfig
import XMonad.Util.Run
-- import XMonad.Util.WorkspaceScreenshot

main = do

  xmonad $ desktopConfig
    { borderWidth = 2
    , modMask     = mod4Mask -- Use the "Win" key for the mod key
    , manageHook  = myManageHook <+> manageHook desktopConfig
    , layoutHook  = desktopLayoutModifiers $ myLayouts
    , logHook     = dynamicLogString quamashPP >>= xmonadPropLog
    }

    `removeKeysP`
      [ "M-S-c" ]

    `additionalKeysP`
      [ ("M-p", shellPrompt myXPConfig)
      , ("M-S-p", manPrompt myXPConfig)                           -- (24)
      -- htop
      , ("M-<Delete>", raiseMaybe (runInTerm "-title htop" "bash -c htop") (title =? "htop"))
      -- banish the pointer
      , ("M-'", banishScreen LowerRight)                          -- (18)
      -- audio
      , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+")
      , ("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-")
      , ("<XF86AudioMute>", spawn "amixer set Master toggle")
      -- (o)ed
      , ("M-o", raiseMaybe (spawn "wine start /unix '/opt/oed/swhx.exe'") (title =? "Oxford English Dictionary"))
      -- (m)utt
      , ("M-m", raiseMaybe (runInTerm "-title mutt" "bash -c mutt") (title =? "mutt"))
      , ("M-c m", raiseMaybe (runInTerm "-title .muttrc" "bash -c 'vim $HOME/.muttrc'") (title =? ".muttrc"))
      , ("M-c a", raiseMaybe (runInTerm "-title aliases.txt" "bash -c 'vim $HOME/.mutt/aliases.txt'") (title =? "aliases.txt"))
      -- (v)im
      , ("M-v", raiseMaybe (runInTerm "-title vim" "bash -c vim") (title =? "vim"))
      , ("M-S-v", prompt "urxvt -e 'vim'" myXPConfig)
      , ("M-c v", raiseMaybe (runInTerm "-title .vimrc" "bash -c 'vim $HOME/.vimrc'") (title =? ".vimrc"))
      -- (e)macs
      , ("M-e", raiseMaybe (spawn "emacs $HOME/todo.org") (className =? "Emacs"))
      , ("M-S-e", runOrRaise "emacs" (className =? "Emacs"))
      , ("M-c e", raiseMaybe (runInTerm "-title init.el" "bash -c 'vim $HOME/.emacs.d/init.el'") (title =? "init.el"))
      -- f(i)refox
      , ("M-i", runOrRaise "firefox" (className =? "Firefox"))
      , ("M-S-i", promptSearch myXPConfig duckduckgo)
      , ("M-/", promptSearch myXPConfig duckduckgo)
      , ("C-S-/", selectSearch duckduckgo)
      -- (x)monad config
      , ("M-c x", raiseMaybe (runInTerm "-title xmonad.hs" "bash -c 'vim $HOME/.xmonad/xmonad.hs'") (title =? "xmonad.hs"))
      -- (b)ash config
      , ("M-c b", raiseMaybe (runInTerm "-title .bashrc" "bash -c 'vim $HOME/.bashrc'") (title =? ".bashrc"))
      -- window manipulation
      , ("M-<Esc>", sendMessage (Toggle "Full"))
      -- print screen
      -- , ("M-S-<Print>", captureWorkspacesWhen defaultPredicate defaultHook horizontally)
      -- (l)ock-screen
      , ("M-S-l", spawn "xscreensaver-command -lock")             -- (0)
      -- get me outta here!
      , ("M-S-a", kill)
      , ("M-S-C-a", killAll)                                      -- (22)
      , ("M-S-q", confirmPrompt myXPConfig "exit" (io exitSuccess))
      ]

myXPConfig = def { position          = Top
                 , alwaysHighlight   = True
                 , promptBorderWidth = 0
                 , font              = "xft:Ubuntu Mono:size=11"
                 , fgColor = "white"
                 , bgColor = "black"
                 }

myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (5/8) [] ||| emptyBSP

myManageHook = composeOne
  [ isDialog              -?> doCenterFloat
  , transience
  ]

-- customLogHook to show windows in xmobar
quamashPP :: PP
quamashPP = def { ppCurrent = xmobarColor "white" "black"
                , ppTitle = xmobarColor "yellow" "" . shorten 60
                , ppLayout = const "" -- to disable the layout info on xmobar
                }

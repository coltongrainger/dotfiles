import System.Exit
import XMonad

import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Layout.StackTile

import XMonad.Actions.Warp         -- (18) warp the mouse pointer
import XMonad.Actions.Submap       -- (19) create keybinding submaps
import XMonad.Actions.Search hiding (Query, images) 
                                   -- (20) some predefined web searches
import XMonad.Actions.WithAll      -- (22) do something with all windows on a workspace
import XMonad.Actions.WindowGo
import XMonad.Actions.RotSlaves
import XMonad.Actions.CycleWindows

import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.AppendFile     -- (25) append to text file
import XMonad.Prompt.Input
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell

import XMonad.Util.EZConfig
import XMonad.Util.Run
-- import XMonad.Util.WorkspaceScreenshot

import qualified XMonad.StackSet as W
import XMonad.Util.NamedWindows ( getName )
import Data.Traversable ( traverse )
import Data.Maybe ( maybeToList )
import Data.List ( (\\), intercalate )

main = do

  xmonad $ desktopConfig
    { terminal    = "urxvt"
    , workspaces  = map show [1..9]
    , borderWidth = 1
    , modMask     = mod4Mask -- Use the "Win" key for the mod key
    , manageHook  = myManageHook <+> manageHook desktopConfig
    , layoutHook  = desktopLayoutModifiers $ myLayouts
    , logHook     = dynamicLogString quamashPP >>= xmonadPropLog
    -- , startupHook = myStartupHook
    }

    `removeKeysP`
      [ "M-S-c" ]

    `additionalKeysP`
      [ ("M-S-q", confirmPrompt myXPConfig "exit" (io exitSuccess))
      -- center the pointer, banish the pointer
      , ("M-'", warpToWindow (1/2) (1/2))
      , ("M-S-'", banishScreen LowerRight)                          -- (18)
      -- window movements 
      , ("M-<Esc>", sendMessage (Toggle "Full"))
      , ("<XF86Forward>" , rotAllDown)
      , ("<XF86Back>" , rotAllUp)
      -- kill windows
      , ("M-S-a", kill)
      , ("M-S-C-a", killAll)                                      -- (22)
      -- run process
      , ("M-p", shellPrompt myXPConfig)
      -- run process in terminal
      , ("M-S-p", prompt "urxvt -e" myXPConfig)
      -- audio controls
      , ("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-")
      , ("<XF86AudioMicMute>", spawn "pavucontrol")
      , ("<XF86AudioMute>", spawn "amixer -D pulse set Master toggle")
      , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+")
      -- display controls
      , ("M-<End>", spawn "xrandr -s 1")
      , ("M-<Home>", spawn "arandr")
      , ("<XF86Launch1>", spawn "xcalib -invert -alter")
      -- open man page
      , ("M-;", manPrompt myXPConfig)                           -- (24)
      -- searches
      , ("M-/", promptSearch myXPConfig google)
      , ("M-S-/", promptSearch myXPConfig duckduckgo)
      , ("S-C-/", selectSearch google)
      -- run named software
      , ("M-i", runOrRaise "firefox" (className =? "Firefox")) -- f(i)refox
      , ("M-0", raiseMaybe (spawn "google-chrome 'https://trello.com/b/ynVgFrfd/todo'") (title=? "todo | Trello - Google Chrome")) -- tod(0)
      , ("M-c c", raiseMaybe (spawn "google-chrome 'https://calendar.google.com/calendar/r'") (title=? "Google Calendar - Google Chrome")) -- (c)alendar
      , ("M-m", raiseMaybe (runInTerm "-title mutt" "bash -c mutt") (title =? "mutt")) -- (m)utt
      , ("M-n", runOrRaise "mnemosyne" (className =? "mnemosyne")) -- m(n)emosyne
      , ("M-o", raiseMaybe (spawn "wine start /unix '/opt/oed/swhx.exe'") (title =? "Oxford English Dictionary")) -- (o)ed
      --, ("M-v", raiseMaybe (runInTerm "-title GhostTextStart" "bash -c 'vim -c \"GhostTextStart\"'") (title =? "GhostTextStart"))
      , ("M-z", runOrRaise "zotero" (className =? "Zotero")) -- (z)otero
      , ("M-<Delete>", raiseMaybe (runInTerm "-title htop" "bash -c htop") (title =? "htop"))
      , ("M-<F5>", raiseMaybe (spawn "/opt/cisco/anyconnect/bin/vpnui") (className =? "Cisco AnyConnect Secure Mobility Client"))
      , ("M-\\", runOrRaise "keepassxc" (className =? "keepassxc")) -- M-S-\ runs autotype ... this shortcut is configured in keepassxc itself
      -- config files
      -- vimrc
      , ("M-c v", raiseMaybe (runInTerm "-title .vimrc" "bash -c 'vim $HOME/.vimrc'") (title =? ".vimrc"))
      -- init.el
      , ("M-c s", raiseMaybe (runInTerm "-title init.el" "bash -c 'vim $HOME/.emacs.d/init.el'") (title =? "init.el"))
      -- bashrc
      , ("M-c b", raiseMaybe (runInTerm "-title .bashrc" "bash -c 'vim $HOME/.bashrc'") (title =? ".bashrc"))
      -- muttrc
      , ("M-c m", raiseMaybe (runInTerm "-title .muttrc" "bash -c 'vim $HOME/.mutt/common.muttrc'") (title =? ".muttrc")) -- edit muttrc
      -- mutt aliases
      , ("M-c a", raiseMaybe (runInTerm "-title aliases" "bash -c 'vim $HOME/.mutt/aliases'") (title =? "aliases")) -- mutt aliases
      -- xmonad.hs
      , ("M-c x", raiseMaybe (runInTerm "-title xmonad.hs" "bash -c 'vim $HOME/.xmonad/xmonad.hs'") (title =? "xmonad.hs"))
      -- edi(t) and com(p)ile stylefiles
      , ("M-c t", raiseMaybe (runInTerm "-title stylefiles" "bash -c 'vim $HOME/fy/19/stylefiles/src'") (title =? "stylefiles"))
      , ("M-c p", raiseMaybe (runInTerm "-title make-stylefiles" "bash -c 'make -C $HOME/fy/19/stylefiles'") (title =? "make-stylefiles"))
      -- mnemosyne
      , ("M-c n", raiseMaybe (runInTerm "-title config.py" "bash -c 'vim $HOME/.config/mnemosyne/config.py'") (title =? "config.py"))
      -- (j)ournal and (q)uamash wiki
      , ("M-c j", raiseMaybe (runInTerm "-title journal" "bash -c 'vim $HOME/journal/index.md'") (title =? "journal")) -- edit journal
      , ("M-c q", raiseMaybe (runInTerm "-title quamash" "bash -c 'cd $HOME/wiki/quamash && vim .'") (title =? "quamash"))
      ]

myXPConfig = def { position          = Top
                 , alwaysHighlight   = True
                 , promptBorderWidth = 0
                 , font    = "-uw-*-medium-i-*-*-14-*-*-*-*-*-*-*"
                 , fgColor = "#839496"
                 , bgColor = "#002b36"
                 }

myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (5/8) [] -- ||| StackTile 1 (3/100) (1/2)

myManageHook = composeOne
  [ isDialog              -?> doCenterFloat
  , transience
  ]

-- customLogHook to show windows in xmobar
quamashPP :: PP
quamashPP = def { ppCurrent = xmobarColor "#268bd2" ""
                , ppTitle = xmobarColor "#b58900" "" . shorten 20
                , ppLayout = const "" -- to disable the layout info on xmobar
                , ppExtras = [logTitles]
                , ppOrder  = \(ws:l:t:ts:_) -> ws : t : [xmobarColor "#839496" "" ts]
                }

-- https://stackoverflow.com/questions/22838932/
logTitles :: X (Maybe String) -- this is a Logger
logTitles = withWindowSet $ fmap (Just . intercalate "  :  ") -- fuse window names
                          . traverse (fmap (shorten 15) . fmap show . getName) -- show window names
                          . (\ws -> W.index ws \\ maybeToList (W.peek ws))

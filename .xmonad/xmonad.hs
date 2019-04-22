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

main = do

  xmonad $ desktopConfig
    { terminal    = "urxvt"
    , workspaces  = map show [1..9]
    , borderWidth = 2
    , modMask     = mod4Mask -- Use the "Win" key for the mod key
    , manageHook  = myManageHook <+> manageHook desktopConfig
    , layoutHook  = desktopLayoutModifiers $ myLayouts
    , logHook     = dynamicLogString quamashPP >>= xmonadPropLog
    -- , startupHook = myStartupHook
    }

    `removeKeysP`
      [ "M-S-c" ]

    `additionalKeysP`
      [ ("M-p", shellPrompt myXPConfig)
      , ("M-S-p", manPrompt myXPConfig)                           -- (24)
      , ("S-C-/", selectSearch google)
      , ("M-z", runOrRaise "zotero" (className =? "Zotero"))
      , ("M-v", raiseMaybe (runInTerm "-title vim" "bash -c vim") (title =? "vim"))
      , ("M-u", raiseMaybe (spawn "jupyter-qtconsole") (className =? "jupyter-qtconsole"))
      , ("M-o", raiseMaybe (spawn "wine start /unix '/opt/oed/swhx.exe'") (title =? "Oxford English Dictionary"))
      , ("M-n", runOrRaise "mnemosyne" (className =? "mnemosyne"))
      , ("M-m", raiseMaybe (runInTerm "-title mutt" "bash -c mutt") (title =? "mutt"))
      , ("M-i", runOrRaise "firefox" (className =? "Firefox"))
      , ("M-c x", raiseMaybe (runInTerm "-title xmonad.hs" "bash -c 'vim $HOME/.xmonad/xmonad.hs'") (title =? "xmonad.hs"))
      , ("M-c v", raiseMaybe (runInTerm "-title .vimrc" "bash -c 'vim $HOME/.vimrc'") (title =? ".vimrc"))
      , ("M-c t", raiseMaybe (runInTerm "-title stylefiles" "bash -c 'vim $HOME/fy/19/stylefiles/src'") (title =? "stylefiles"))
      , ("M-c s", raiseMaybe (runInTerm "-title init.el" "bash -c 'vim $HOME/.emacs.d/init.el'") (title =? "init.el"))
      , ("M-c q", raiseMaybe (runInTerm "-title quamash" "bash -c 'cd $HOME/wiki/quamash && vim .'") (title =? "quamash"))
      , ("M-c p", raiseMaybe (runInTerm "-title make-stylefiles" "bash -c 'make -C $HOME/fy/19/stylefiles'") (title =? "make-stylefiles"))
      , ("M-c n", raiseMaybe (runInTerm "-title config.py" "bash -c 'vim $HOME/.config/mnemosyne/config.py'") (title =? "config.py"))
      , ("M-c m", raiseMaybe (runInTerm "-title .muttrc" "bash -c 'vim $HOME/.muttrc'") (title =? ".muttrc"))
      , ("M-c j", raiseMaybe (runInTerm "-title journal" "bash -c 'vim $HOME/journal/index.md'") (title =? "journal"))
      , ("M-c b", raiseMaybe (runInTerm "-title .bashrc" "bash -c 'vim $HOME/.bashrc'") (title =? ".bashrc"))
      , ("M-c a", raiseMaybe (runInTerm "-title aliases.txt" "bash -c 'vim $HOME/.mutt/aliases.txt'") (title =? "aliases.txt"))
      , ("M-S-v", prompt "urxvt -e 'vim'" myXPConfig)
      , ("M-S-q", confirmPrompt myXPConfig "exit" (io exitSuccess))
      , ("M-S-l", spawn "xscreensaver-command -lock")             -- (0)
      , ("M-S-a", kill)
      , ("M-S-C-a", killAll)                                      -- (22)
      , ("M-S-/", promptSearch myXPConfig duckduckgo)
      , ("M-C-p", runOrRaise "keepassxc" (className =? "keepassxc"))
      , ("M-C-S-p", spawn "/usr/bin/keepassxc --auto-type")
      , ("M-<Page_Up>", spawn "xcalib -invert -alter")
      , ("M-<Home>", spawn "xrandr --output VGA-1 --mode 1920x1080 --pos 1360x0 --rotate normal --output LVDS-1 --primary --mode 1360x768 --pos 0x0 --rotate normal --output HDMI-3 --off --output HDMI-2 --off --output HDMI-1 --off --output DP-3 --off --output DP-2 --off --output DP-1 --off")
      , ("M-<Esc>", sendMessage (Toggle "Full"))
      , ("M-<End>", spawn "xrandr -s 1")
      , ("M-<Delete>", raiseMaybe (runInTerm "-title htop" "bash -c htop") (title =? "htop"))
      , ("M-/", promptSearch myXPConfig google)
      , ("M-'", banishScreen LowerRight)                          -- (18)
      , ("<XF86Launch1>", spawn "arandr")
      , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+")
      , ("<XF86AudioMute>", spawn "amixer -D pulse set Master toggle")
      , ("<XF86AudioMicMute>", spawn "pavucontrol")
      , ("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-")
      -- , ("M-<Tab>", cycleRecentWindows [xK_Super_L] xK_Tab xK_Tab)
      , ("M-[" , rotSlavesUp)
      , ("M-]" , rotSlavesDown)
      , ("M-S-[" , rotAllUp)
      , ("M-S-]" , rotAllDown)
      ]

-- myStartupHook :: X ()
-- myStartupHook = do
--         spawn "keepassxc"

myXPConfig = def { position          = Top
                 , alwaysHighlight   = True
                 , promptBorderWidth = 0
                 , font    = "-*-fixed-*-*-*-*-12-*-*-*-*-*-*-*"
                 , fgColor = "white"
                 , bgColor = "black"
                 }

myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (5/8) [] ||| StackTile 1 (3/100) (1/2)

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

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
import XMonad.Actions.SpawnOn      -- (22a) start programs on a particular WS
import XMonad.Actions.TopicSpace   -- (22b) set a "topic" for each workspace

import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.Input
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell

import XMonad.Util.EZConfig
import XMonad.Util.Run

--------------------------------------------------------------------------------
main = do
  spawn "xmobar"

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
      [ ("M-S-q", confirmPrompt myXPConfig "exit" (io exitSuccess))
      , ("M-S-a", kill)
      , ("M-S-C-a", killAll)                                      -- (22)
      -- layout
      , ("M-<Esc>", sendMessage (Toggle "Full"))
      -- start programs
      , ("M-o", spawn "wine start /unix '/opt/oed/swhx.exe'")
      , ("M-m", spawn "urxvt -e mutt")
      , ("M-<Delete>", spawn "urxvt -e htop")
      -- prompts
      , ("M-p", shellPrompt myXPConfig)
      , ("M-h", manPrompt myXPConfig)                           -- (24)
      -- searches
      , ("M-/", promptSearch myXPConfig duckduckgo)
      , ("M-S-/", selectSearch duckduckgo)
      -- lock the screen with xscreensaver
      , ("M-S-l", spawn "xscreensaver-command -lock")             -- (0)
      -- bainsh the pointer
      , ("M-'", banishScreen LowerRight)                          -- (18)
      -- audio
      , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+")
      , ("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-")
      , ("<XF86AudioMute>", spawn "amixer set Master toggle")
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
    others = ResizableTall 1 (1.5/100) (3/5) [] ||| emptyBSP

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

module Main (main) where

--------------------------------------------------------------------------------
import System.Exit
import XMonad
import qualified XMonad.StackSet as W  -- (0a) window stack manipulation
import qualified Data.Map as M         -- (0b) map creation
import Data.List ((\\), find)
import Data.Maybe (isJust, catMaybes)
import Data.Monoid
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

--------------------------------------------------------------------------------
main = do
  spawn "xmobar"

  xmonad $ desktopConfig
    { borderWidth = 2
    , modMask     = mod4Mask -- Use the "Win" key for the mod key
    , manageHook  = myManageHook <+> manageHook desktopConfig
    , layoutHook  = desktopLayoutModifiers $ myLayouts
    , logHook     = dynamicLogString coltongraingerPP >>= xmonadPropLog
    }

    `additionalKeysP` 
      [ ("M-S-q", confirmPrompt myXPConfig "exit" (io exitSuccess))
      , ("M-p e", shellPrompt myXPConfig)
      , ("M-p m", manPrompt myXPConfig)                           -- (24)
      , ("M-b", prompt ("firefox -search") amberXPConfig)
      , ("M-c", prompt ("urxvt -e bash -i -c") greenXPConfig)
      , ("M-<Esc>", sendMessage (Toggle "Full"))
      , ("M-S-a", kill)                                           -- (0)
      , ("M-S-C-a", killAll)                                      -- (22)
      , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+")
      , ("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-")
      , ("<XF86AudioMute>", spawn "amixer set Master toggle")
      -- lock the screen with xscreensaver
      , ("M-S-l", spawn "xscreensaver-command -lock")             -- (0)
      -- bainsh the pointer
      , ("M-'", banishScreen LowerRight)                          -- (18)
      -- some searches.
      , ("M-/", submap . mySearchMap $ myPromptSearch)            -- (19,20)
      , ("M-C-/", submap . mySearchMap $ mySelectSearch)          -- (19,20)
      ]

-- Perform a search, using the given method, based on a keypress
mySearchMap method = M.fromList $                               -- (0b)
        [ ((0, xK_g), method google)                            -- (20)
        , ((0, xK_w), method wikipedia)                         --  "
        , ((0, xK_h), method hoogle)                            --  "
        , ((shiftMask, xK_h), method hackage)                   --  "
        , ((0, xK_s), method scholar)                           --  "
        , ((0, xK_m), method mathworld)                         --  "
        , ((0, xK_p), method maps)                              --  "
        , ((0, xK_d), method dictionary)                        --  "
        , ((0, xK_a), method alpha)                             --  "
        , ((0, xK_l), method lucky)                             --  "

        -- custom searches (see below)
        , ((0, xK_i), method images)
        , ((0, xK_k), method greek)
        ]

-- Search Perseus for ancient Greek dictionary entries
greek  = searchEngine "greek"  "http://www.perseus.tufts.edu/hopper/morph?la=greek&l="

-- for some strange reason the image search that comes with the Search module
-- is for google.fr
images = searchEngine "images" "http://www.google.com/search?hl=en&tbm=isch&q="

-- Prompt search: get input from the user via a prompt, then
--   run the search in firefox and automatically switch to the web
--   workspace
myPromptSearch (SearchEngine _ site)
  = inputPrompt myXPConfig "Search" ?+ \s ->                    -- (27)
      (search "firefox" site s)                      -- (0,20)

-- Select search: do a search based on the X selection
mySelectSearch eng = selectSearch eng                -- (20)

myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = "xft:Ubuntu Mono:size=10"
  }

-- customLogHook to show windows in xmobar
coltongraingerPP :: PP
coltongraingerPP = def { ppCurrent = xmobarColor "white" "black"
                 , ppTitle = xmobarColor "#00ee00" "" . shorten 60
                 , ppLayout = const "" -- to disable the layout info on xmobar
                 }

myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (3/5) [] ||| emptyBSP


myManageHook = composeOne
  [ isDialog              -?> doCenterFloat
  , transience
  ]

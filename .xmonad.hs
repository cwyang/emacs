--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
-- refer John Goerzen's Configuration 
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.ResizableTile
import System.IO
import System.Exit
import XMonad.Hooks.SetWMName
import XMonad.Layout.Grid 
import XMonad.Util.Paste

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Layout.Tabbed as Tab

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal2      = "xterm -fn \"*-terminus-medium-r-normal--16-*\""
foomyTerminal      = "/usr/local/bin/hanterm -sl 2000 -fn \"*-terminus-medium-r-normal--16-*\" -hfn \"*-roundgothic-medium-*--16-*\" -lsp 1"
--myTerminal      = "/usr/local/bin/mlterm -k esc -n"
myTerminal      = "mlterm -k esc -n --ucsnoconv=U+2500-257F" -- except box character
myTerminal3      = "TERM=xterm-color /usr/local/bin/mlterm -k esc -n"
--myTerminal     = "xterm -sl 2000"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod3Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
--myNumlockMask   = mod2Mask
myNumlockMask   = 0

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal (New)
    [ ((modm, xK_n), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_n), spawn myTerminal2)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_run` && eval \"exec $exe\"")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window (Die)
    , ((modm .|. shiftMask, xK_d     ), kill)

    , ((controlMask, xK_Return), spawn "xterm")

     -- Rotate through the available layout algorithms (yet anoterh)
    , ((modm,               xK_y ), sendMessage NextLayout)
    , ((modm,               xK_t ), sendMessage NextLayout) -- left hand

    --  Reset the layouts on the current workspace to default (!y)
    , ((modm .|. shiftMask, xK_y ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_semicolon     ), refresh)

    -- Move focus to the next window (ijkl)
    , ((modm ,               xK_k     ), windows W.focusDown)

    -- Move focus to the previous window (ijkl)
    , ((modm ,               xK_i     ), windows W.focusUp  )

    -- Move focus to the master window (master)
    , ((modm,               xK_m     ), windows W.focusMaster  )

    , ((modm, xK_g), spawn "xdotool key alt+Left") -- navigate back

    -- Swap the focused window and the master window (home)
    , ((modm .|. shiftMask, xK_h), windows W.swapMaster)

    -- Swap the focused window with the next window
    --    , ((modm .|. shiftMask, xK_h     ), windows W.swapDown  )
    , ((modm, xK_h     ), (windows W.swapDown >> windows W.focusUp))

    -- Swap the focused window with the next window (ijkl)
    , ((modm .|. shiftMask, xK_k     ), windows W.swapDown  )

    , ((modm .|. controlMask, xK_k     ), do sendKey controlMask xK_z -- TMUX pane navigation
					     sendKey 0 xK_o)
    , ((modm .|. controlMask, xK_i     ), do sendKey controlMask xK_z -- TMUX pane navigation
					     sendKey shiftMask xK_o)
    -- Swap the focused window with the previous window (ijkl)
    , ((modm .|. shiftMask, xK_i     ), windows W.swapUp    )

    -- Shrink the master area (ijkl)
    , ((modm .|. shiftMask, xK_j     ), sendMessage MirrorExpand    )

    -- Expand the master area (ijkl)
    , ((modm .|. shiftMask, xK_l     ), sendMessage MirrorShrink    )

    -- Shrink the master area (ijkl)
    , ((modm,               xK_j     ), sendMessage Shrink)

    -- Expand the master area (ijkl)
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm .|. shiftMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    --    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    --    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modm , xK_b ), sendMessage ToggleStruts)
 
    -- Quit xmonad (Quit)
--    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_q     ), spawn "cinnamon-session-quit --logout")

    -- Suspend
    , ((modm .|. shiftMask .|. controlMask, xK_z     ), spawn "/home/cwyang/bin/suspend")
 
    -- Restart xmonad (quaff)
    , ((modm              , xK_q     ), restart "xmonad" True)
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
--    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
    , ((modMask, button2), (\w -> spawn "xdotool key ctrl+w")) -- to close popup
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Grid ||| Full  -- ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     -- tiled   = ResizableTall nmaster delta ratio
     tiled   = ResizableTall nmaster delta ratio []
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio   = 107/200
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "mplayer2"           --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
myLogHook = return ()
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--myStartupHook = return ()
myStartupHook = setWMName "LG3D" -- to work with java
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
        xmproc <- spawnPipe "/home/cwyang/bin/xmobar -x 1 /home/cwyang/.xmobarrc"
        xmonad $ defaults {
                 manageHook = manageDocks <+> myManageHook <+> manageHook defaults,
                 layoutHook = avoidStruts $ layoutHook defaults,
                 logHook = dynamicLogWithPP $ xmobarPP {
                     ppOutput = hPutStrLn xmproc,
                     ppTitle = xmobarColor "green" "" . shorten 50
                     }
        } `additionalKeys`
            [ ((myModMask .|. shiftMask, xK_z), spawn "cinnamon-screensaver-command -l; xset dpms force off")
            , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
            , ((0, xK_Print), spawn "scrot")
            ]
 
--            [ ((myModMask .|. shiftMask, xK_z), spawn "xlock -font fixed")
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
--        numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
        layoutHook         = myLayout,
--        manageHook         = myManageHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

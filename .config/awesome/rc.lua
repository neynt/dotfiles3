-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Better layouts (3rd party)
local lain = require("lain")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

awful.spawn.with_shell("xrdb ~/.Xresources")

local keys = require("keys")

-- Error handling
if awesome.startup_errors then
  -- Check if awesome encountered an error during startup and fell back to
  -- another config (This code will only ever execute for the fallback config)
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    })
    in_error = false
  end)
end

-- Utils
rrect = function(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")
beautiful.notification_shape = rrect(beautiful.notification_border_radius)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Table of layouts to cover with awful.layout.inc, order matters.
lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
awful.layout.layouts = {
  lain.layout.centerwork,
  lain.layout.termfair.center,
  awful.layout.suit.tile.right,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal },
  },
})

mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu,
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%Y-%m-%d (%a) %H:%M", 1)

-- Create a wibox for each screen and add it
local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- smartly maximize if there is only one tiled client
function smart_borders (s)
  local layout = awful.layout.getname(awful.layout.get(s))

  local num_tiled = 0
  for _, c in pairs(s.clients) do
    if not c.floating then
      num_tiled = num_tiled + 1
    end
  end

  if layout == "floating" then
    num_tiled = 2
  end

  for _, c in pairs(s.clients) do
    --if num_tiled <= 1 or layout == "max" then
    if layout == "max" then
      c.border_width = 0
      beautiful.useless_gap = 0
    else
      c.border_width = beautiful.border_width
      beautiful.useless_gap = beautiful.useless_gap_orig
    end
    if c.floating or layout == "floating" then
      -- Floaters are always on top, bordered, and above
      c.size_hints_honor = true
      c.border_width = beautiful.border_width
      if not c.fullscreen then
        -- and above
        c.above = true
      end
    else
      c.above = false
      c.size_hints_honor = false
    end
  end
end

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = keys.taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.focused,
    buttons = keys.tasklist_buttons
  }

  -- left, right, top, bottom
  local systray = wibox.widget.systray()
  systray:set_base_size(16)
  s.systray = wibox.container.margin(systray, 8, 8, 1, 3)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    -- Left widgets
    { layout = wibox.layout.fixed.horizontal,
      --mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    wibox.container.margin(
      s.mytasklist, -- Middle widget
      5, 0, 0, 0
    ),
    --nil,
    -- Right widgets
    { layout = wibox.layout.fixed.horizontal,
      --mykeyboardlayout,
      s.systray,
      mytextclock,
      wibox.container.margin(s.mylayoutbox, 8, 3, 1, 3),
    },
  }

  s:connect_signal("tag::history::update", function() smart_borders(s) end)
end)
-- }}}

root.buttons(gears.table.join(
  --awful.button({ }, 3, function () mymainmenu:toggle() end)
  --awful.button({ }, 4, awful.tag.viewnext),
  --awful.button({ }, 5, awful.tag.viewprev)
))
root.keys(keys.globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.clientkeys,
      buttons = keys.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
    },
  },

  -- Disallow Godot from maximizing itself.
  { rule = { class = "Godot" }, properties = { maximized = false, }, },
  { rule = { class = "Godot_Editor" }, properties = { maximized = false, }, },
  { rule = { name = "Plover: Suggestions" }, properties = { floating = false, }, },

  -- Floating clients.
  { rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "Pystopwatch",
        "Gcolor2",
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",     -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = {
      floating = true,
      ontop = true,
    },
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } }
  , properties = { titlebars_enabled = true }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
local adjust_client = function (c)
  if c.fullscreen or c.maximized then
    -- Don't draw a border for maximized windows.
    --c.border_width = 0
    c.shape = nil
  else
    --c.border_width = beautiful.border_width
    -- Rounded borders
    c.shape = rrect(beautiful.border_radius)
  end

  if c.floating or (c.first_tag and c.first_tag.layout == awful.layout.suit.floating) then
    --awful.titlebar.show(c)
    --c.ontop = true
    --c.size_hints_honor = true
  else
    --awful.titlebar.hide(c)
    --c.ontop = false
    --c.size_hints_honor = false
  end

  smart_borders(c.screen)
end

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end

  adjust_client(c)
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  local titlebar_padding = {
    layout = wibox.layout.fixed.horizontal,
  }
  awful.titlebar(c, { size = beautiful.useless_gap, position = 'top' }) : setup(titlebar_padding)
  awful.titlebar(c, { size = beautiful.useless_gap, position = 'bottom' }) : setup(titlebar_padding)
  awful.titlebar(c, { size = beautiful.useless_gap, position = 'right' }) : setup(titlebar_padding)
  awful.titlebar(c, { size = beautiful.useless_gap, position = 'left' }) : setup(titlebar_padding)
end)

client.connect_signal("focus",   function(c)
  c.border_color = beautiful.border_focus
  adjust_client(c)
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}

client.connect_signal("property::maximized", adjust_client)
client.connect_signal("property::fullscreen", adjust_client)
client.connect_signal("property::floating", adjust_client)
client.connect_signal("request::unmanage", adjust_client)

awful.spawn("setxkbmap -option compose:ralt")
awful.spawn("setxkbmap -option ctrl:nocaps")
awful.spawn("xinput set-prop 'DLL07BE:01 06CB:7A13 Touchpad' 'libinput Disable While Typing Enabled' 0")
awful.spawn("ibus-daemon -drx")

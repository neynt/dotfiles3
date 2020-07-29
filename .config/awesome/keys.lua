local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local keys = {}

modkey = "Mod4"

keys.globalkeys = gears.table.join(
  awful.key({ modkey,           }, "s",      hotkeys_popup.show_help, { description="show help", group="awesome" }),
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext, { description = "view next", group = "tag" }),
  --awful.key({ modkey,           }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
  --awful.key({ modkey,           }, "w", function () mymainmenu:show() end, { description = "show main menu", group = "awesome" }),

  -- Layout manipulation
  awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)  end, { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  -- Standard program
  awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal) end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  awful.key({ modkey,           }, "l", function () awful.tag.incmwfact( 0.05) end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey,           }, "h", function () awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift"   }, "h", function () awful.tag.incnmaster( 1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift"   }, "l", function () awful.tag.incnmaster(-1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),
  --awful.key({ modkey,           }, "space", function () awful.layout.inc( 1) end, { description = "select next", group = "layout" }),
  --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end, { description = "select previous", group = "layout" }),
  --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end, { description = "select previous", group = "layout" }),

  awful.key({ modkey            }, "equal", function()
    -- find out some things
    naughty.notify({
      title = "Hello",
      text = tostring(#g.systray:get_all_children()[1]:buttons()),
    })
  end, { description = "yote", group = "launcher" }),


  -- Media keys
  awful.key({ }, "XF86AudioRaiseVolume",     function () awful.spawn.with_shell("volume.sh up") end),
  awful.key({ }, "XF86AudioLowerVolume",     function () awful.spawn.with_shell("volume.sh down") end),
  awful.key({ }, "XF86AudioMute",            function () awful.spawn.with_shell("volume.sh toggle") end),
  awful.key({ }, "XF86MonBrightnessUp",      function () awful.spawn.with_shell("brightness.sh up") end),
  awful.key({ }, "XF86MonBrightnessDown",    function () awful.spawn.with_shell("brightness.sh down") end),
  awful.key({                    }, "Print", function () awful.spawn.with_shell("screenshot.sh") end),
  awful.key({ "Control",         }, "Print", function () awful.spawn.with_shell("screenshot.sh -f") end),
  awful.key({ "Control", "Shift" }, "Print", function () awful.spawn.with_shell("screenshot.sh -c") end),
  awful.key({ "Mod1"             }, "Print", function () awful.spawn.with_shell("ocr.sh") end),

  awful.key({ "Control", "Mod1"  }, "l",     function () awful.spawn.with_shell("slock") end),

  awful.key({ modkey, "Control" }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
        "request::activate", "key.unminimize", {raise = true}
        )
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
    { description = "run prompt", group = "launcher" }),

  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt     = "Run Lua code: ",
        textbox    = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" }),
  -- Menubar
  awful.key({ modkey }, "p", menubar.show, { description = "show the menubar", group = "launcher" }))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for _, i in ipairs({1, 2, 3, 4, 5, 6, 7, 8, 9, 10}) do
  keys.globalkeys = gears.table.join(keys.globalkeys
 -- View tag only.
 , awful.key({ modkey }, "#" .. i + 9,
     function ()
       local screen = awful.screen.focused()
       local tag = screen.tags[i]
       if tag then
         tag:view_only()
       end
     end,
     { description = "view tag #"..i, group = "tag" })
 -- Move client to tag.
 , awful.key({ modkey, "Shift" }, "#" .. i + 9,
     function ()
       if client.focus then
         local tag = client.focus.screen.tags[i]
         if tag then
           client.focus:move_to_tag(tag)
         end
       end
     end,
     { description = "move focused client to tag #"..i, group = "tag" })
 )
end

keys.clientkeys = gears.table.join(
  awful.key({ modkey,       }, "f", function (c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey,           }, "y", function (c)
    awful.client.floating.toggle(c)
    c.ontop = c.floating
  end, { description = "toggle floating", group = "client" }),
  awful.key({ modkey, "Shift"   }, "c", function (c)
    --naughty.notify({
    --  text = "killing...",
    --})
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end, { description = "move to master", group = "client" }),

  awful.key({ modkey,           }, "o", function (c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),

  awful.key({ modkey,           }, "t", function (c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),

  -- The client currently has the input focus, so it cannot be
  -- minimized, since minimized clients can't have the focus.
  --awful.key({ modkey,           }, "n", function (c) c.minimized = true end,         { description = "minimize", group = "client" }),
  awful.key({ modkey,           }, "m", function (c) c.maximized = not c.maximized c:raise() end, { description = "(un)maximize", group = "client" })
)

keys.taglist_buttons = gears.table.join
( awful.button({ }, 1, function(t) t:view_only() end)
--, awful.button({ modkey }, 1, function(t)
--    if client.focus then
--      client.focus:move_to_tag(t)
--    end
--  end)
, awful.button({ }, 3, awful.tag.viewtoggle)
--, awful.button({ modkey }, 3, function(t)
--    if client.focus then
--      client.focus:toggle_tag(t)
--    end
--  end)
--, awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end)
--, awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

keys.tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "tasklist", { raise = true })
  end)
  --awful.button({ }, 3, function()
  --  awful.menu.client_list({ theme = { width = 250 } })
  --end),
  --awful.button({ }, 4, function ()
  --  awful.client.focus.byidx(1)
  --end),
  --awful.button({ }, 5, function ()
  --  awful.client.focus.byidx(-1)
  --end)
)

keys.clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end))

return keys

-- -- NOVA-FD Awesome Setup -- --
-- -- Created by Matt Burchett -- --
-- -- Fri, 2010/06/28 -- --

-- -- LIBRARY REQUIREMENTS -- --
-- -- THERE MAY BE LIBRARIES COMMENTED OUT THAT ARE CURRENTLY OUT OF USE -- --
require("awful") 			-- Standard Awesome Library
require("awful.autofocus")		-- Standard Awesome Library
require("awful.rules")			-- Standard Awesome Library
require("beautiful")			-- Theme Handling Library
require("naughty")			-- Notification Library
require("vicious")			-- Dynamic Widget Library
require("lib/cal")				-- Calendar Library / Widget
require("debian.menu") 			-- Debian Menu Generator, don't have to create a menu! WHOO!
-- -- APP AUTOSTART -- --
awful.util.spawn_with_shell("conky")
awful.util.spawn_with_shell("dropbox start")
awful.util.spawn_with_shell("wicd-gtk")

-- DISABLE BUSY CURSOR WITH AWFUL.UTIL.SPAWN --
-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end

-- -- VARIABLE DEFINITIONS -- --

-- -- SPECIFY THEME LOCATION (CONSISTS OF COLOURS, ICONS, AND WALLPAPERS) -- --
beautiful.init("/home/burchettm/.config/awesome/themes/awesomeo/theme.lua")

-- CHANGE NAUGHTY FONT TO DIFFER FROM BANKGOTHIC LT BT --
naughty.config.default_preset.font = "Sans 8"

-- -- SPECIFY DEFAULT APPLICATIONS -- --
terminal = "/usr/bin/xfce4-terminal --hide-menubar"			-- Specify Default Terminal
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4" -- Set ModKey to Windows Key, use xmodmap to change

-- -- LAYOUTS -- --
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

-- -- TAGS --  --
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "WORK", "TERM", "WWW", "CHAT", "MEDIA", "SOCIAL" }, s,
 { layouts[1], layouts[2], layouts[2],          -- Tags: 1, 2, 3
   layouts[1], layouts[1], layouts[1],          --       4, 5 ,6
   layouts[1], layouts[1], layouts[1]           --       7, 8, 9
 })
end

-- -- MENU -- --

myawesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit Config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "Restart", awesome.restart },
   { "Quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { " ", " " },
                                    { "GMPC", "gmpc" },
                                    { "Opera", "opera" },
                                    { "Pidgin", "pidgin" },
                                    { "Skype", "skype" },
                                    { "TeamSpeak3", "/home/burchettm/teamspeak3/ts3client_runscript.sh" },
                                    { "Terminal", terminal },
                                    { "Thunderbird", "thunderbird" },
                                    { "Turpial", "turpial" },
                                    { "VLC", "vlc" },
                                    { " ", " " },
                                    { "Debian", debian.menu.Debian_menu.Debian, beautiful.ubuntu_icon },
                                    { " ", " " },
                                    { "Awesome", myawesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.ubuntu_icon),
                                     menu = mymainmenu })

-- -- WIBOXES -- --

mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
--                    awful.button({ }, 3, awful.tag.viewtoggle), -- toggle viewing of other workspaces
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.

    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
-- WIDGETS --

-- TEXT CLOCK --
mytextclock = awful.widget.textclock({ align = "right" }, "%H:%M:%S ", 1)

-- DATE -- 
mytextdate = awful.widget.textclock({ align = "right"}, "%a, %Y/%m/%d", 1)

-- CALENDAR --
cal.register(mytextdate, "<b><u>%s</u></b>") -- Added Calendar tooltip to date, bolded day & underlined day

-- SYSTRAY --
mysystray = widget({ type = "systray" })

-- SPACER --
myspacer = widget({ type = "textbox" })
myspacer.text = " | "

-- TAG LIST -- 
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

-- TASKLIST -- 
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

-- VOLUME --
volumewidget = widget ({ type = "textbox" })
vicious.register( volumewidget, vicious.widgets.volume, " $2 $1%", 2, "Master")
volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("urxvt -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 5%+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 5%-", false) end)
))

-- WEATHER --

weatherwidget = widget ({ type = "textbox" })
   vicious.register( weatherwidget, vicious.widgets.weather, '${tempf}°F',300, 'KSTL')

-- TOP BOX --
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        myspacer,
        mytextdate,
        myspacer,
        weatherwidget,
        myspacer,
        volumewidget,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

-- BOTTOM BOX -- 
--infobox = {}
--infobox[s] = awful.wibox({ position = "bottom", screen = s })
--infobox[s].widgets = { musicwidget.widget,
--                       layout = awful.widget.layout.horizontal.leftright }

end
-- -- BINDINGS -- --

-- MOUSE -- 
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- KEYBOARD --
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- User Added Keybindings
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+") end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-") end),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),    
    awful.key({}, "Print", function () awful.util.spawn("scrotshooter") end),
    awful.key({}, "Alt_Sys_Req", function () awful.util.spawn("scrotshooter-aprint") end),
    awful.key({modkey }, "p", function() awful.util.spawn( "dmenu_run" ) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-- -- RULES -- --

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Opera" }, properties = { tag = tags[1][3] } },
    { rule = { class = "Pidgin" }, properties = { tag = tags[1][4] } },
    { rule = { class = "Skype" }, properties = { tag = tags[1][4]  } },
    { rule = { class = "Sonata" }, properties = { tag = tags[1][5] } },
    { rule = { class = "Turpial" }, properties = { tag = tags[1][6] } },
    { rule = { class = "Gmpc" }, properties = { tag = tags[1][5] } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}

-- -- SIGNALS -- --

-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


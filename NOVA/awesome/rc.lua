-- -- NOVA Awesome Setup -- --
-- -- Created by Matt Burchett -- --
-- -- Fri, 2010/06/10 -- --

-- -- LIBRARY REQUIREMENTS -- --
-- -- THERE MAY BE LIBRARIES COMMENTED OUT THAT ARE CURRENTLY OUT OF USE -- --
require("awful") 			-- Standard Awesome Library
require("awful.autofocus")		-- Standard Awesome Library
require("awful.rules")			-- Standard Awesome Library
require("beautiful")			-- Theme Handling Library
require("naughty")			-- Notification Library
require("vicious")			-- Dynamic Widget Library
require("lib/cal")				-- Calendar Library / Widget

-- -- APP AUTOSTART -- --
awful.util.spawn_with_shell("dropboxd")
awful.util.spawn_with_shell("mpd")
awful.util.spawn_with_shell("/usr/lib/vino/vino-server --sm-disable")
awful.util.spawn_with_shell("/usr/bin/numlockx")
awful.util.spawn_with_shell("wmname LG3D")

-- DISABLE BUSY CURSOR WITH AWFUL.UTIL.SPAWN --
-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end

-- -- VARIABLE DEFINITIONS -- --

-- -- SPECIFY THEME LOCATION (CONSISTS OF COLOURS, ICONS, AND WALLPAPERS) -- --
beautiful.init("/home/burchettm/.config/awesome/themes/awesomeo/theme.lua")

-- -- SPECIFY DEFAULT APPLICATIONS -- --
terminal = "/usr/bin/terminal --hide-menubar"			-- Specify Default Terminal
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
    tags[s] = awful.tag({ "work", "term", "www", "chat", "media", "social" }, s,
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

myaccessoriesmenu = {
   { "Android Notifier Desktop", "/usr/share/android-notifier-desktop/run.sh" },
   { "Application Finder", "xfce4-appfinder" },
   { "Archive Manager", "file-roller" },
   { "Avant Window Navigator", "avant-window-navigator" },
   { "ClamTK", "clamtk" },
   { "Disk Utility", "palimpsest" },
   { "DOSBOX Emulator", "dosbox" },
   { "gShot", "gshot" },
   { "gVim", "gvim" },
   { "LXDE Image Viewer", "gpicview" },
   { "KeePassX", "keepassx" },
   { "LXTerminal", "lxtermnal" },
   { "Mousepad", "mousepad" },
   { "Orage Globaltime", "globaltime" },
   { "PCManFM File Manager", "pcmanfm" },
   { "Root Terminal", "gksu -l gnome-terminal" },
   { "ROXTerm", "roxterm" },
   { "Sakura", "sakura" },
   { "Screenshot", "xfce4-screenshooter" },
   { "Sensor Viewer", "xfce4-sensors" },
   { "Squeeze", "squeeze" },
   { "Terminator", "terminator" },
   { "Virus Scanner", "clamtk" },
   { "Xarchiver", "xarchiver" }
}

myarchmenu = {
   { "AUR", "xdg-open http://aur.archlinux.org" },
   { "Bugs", "xdg-open http://bugs.archlinux.org" },
   { "Developers", "xdg-open http://www.archlinux.org/developers/" },
   { "Documentation", "xdg-open http://wiki.archlinux.org/index.php/Official_Arch_Linux_Install_Guide" },
   { "Donate", "xdg-open http://www.archlinux.org/donate/" },
   { "Forum", "xdg-open http://bbs.archlinux.org" },
   { "Homepage", "xdg-open http://repos.archlinux.org" },
   { "SVN", "xdg-open http://repos.archlinux.org" },
   { "Schwag", "xdg-open http://www.zazzle.com/archlinux/" },
   { "Wiki", "xdg-open http://wiki.archlinux.org" }
}

mygamesmenu = {
   { "Alien Arena", "alienarena" },
   { "America's Army 3", "env WINEPREFIX='/home/burchettm/.wineprefix/Steam' wine winebrowser steam://rungameid/13140" },
   { "Ceiling Fan Man", "env WINEPREFIX='/home/burchettm/.wineprefix/SFGames' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/SFGames/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Skyfall/Ceiling\\ Fan\\ Man/Play\\ Ceiling\\ Fan\\ Man.lnk" },
   { "Ceiling Fan Man II", "env WINEPREFIX='/home/burchettm/.wineprefix/SFGames' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/SFGames/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Skyfall/Ceiling\\ Fan\\ Man\\ II\\ Demo/Play\\ Ceiling\\ Fan\\ Man\\ II.lnk" },
   { "Curse Client", "env WINEPREFIX='/home/burchettm/.wineprefix/Curse' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Curse/dosdevices/c:/users/Public/Start\\ Menu/Programs/Curse/Curse\\ Client.lnk" },
   { "Fallout 3", "env WINEPREFIX='/home/burchettm/.wineprefix/Fallout3' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Fallout3/dosdevices/c:/users/Public/Start\\ Menu/Programs/Bethesda\\ Softworks/Fallout\\ 3/Fallout\\ 3.lnk" },
   { "Frets on Fire", "fretsonfire" },
   { "GCFScape", "env WINEPREFIX='/home/burchettm/.wine' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wine/dosdevices/c:/users/Public/Start\\ Menu/Programs/GCFScape/GCFScape.lnk" },
   { "GTA San Andreas", "env WINEPREFIX='/home/burchettm/.wineprefix/GTASA' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/GTASA/dosdevices/c:/users/Public/Start\\ Menu/Programs/Rockstar\\ Games/GTA\\ San\\ Andreas/Play\\ GTA\\ San\\ Andreas.lnk" },
   { "Imprudence", "/usr/bin/imprudence-secondlife" },
   { "Infiltration", "env WINEPREFIX='/home/burchettm/.wineprefix/UT' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/UT/dosdevices/c:/users/Public/Start\\ Menu/Programs/SentryStudios/Infiltration/Play\\ Infiltration.lnk" },
   { "LinCity-NG", "lincity-ng" },
   { "MaNGOLin", "/home/burchettm/Apps/MaNGOLin/MaNGOLin" },
   { "MCEdit", "python26 -O '/home/burchettm/Apps/MCEdit-linux/MCEditData/mcedit.pyo'" },
   { "Minecraft", "minecraft" },
   { "Oblivion", "env WINEPREFIX='/home/burchettm/.wineprefix/Oblivion' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Oblivion/dosdevices/c:/users/Public/Start\\ Menu/Programs/Bethesda\\ Softworks/Oblivion/Oblivion.lnk" },
   { "PlayOnLinux", "playonlinux" },
   { "Second Life", "/usr/bin/secondlife" },
   { "SimCity 4 Deluxe", "env WINEPREFIX='/home/burchettm/.wineprefix/SimCity4' wine '/home/burchettm/.wineprefix/SimCity4/drive_c/Program Files/Maxis/SimCity 4 Deluxe/Apps/SimCity 4.exe' -intro:off -customresolution:enabled -r1920x1080x32" },
   { "Sims 3", "env WINEPREFIX='/home/burchettm/.wineprefix/TheSims3' wine '/home/burchettm/.wineprefix/TheSims3/drive_c/Program Files/Electronic Arts/The Sims 3 Outdoor Living Stuff/Game/Bin/TS3SP03.exe'" },
   { "SLiteChat", "env WINEPREFIX='/home/burchettm/.wine' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wine/dosdevices/c:/users/Public/Start\\ Menu/Programs/SLiteChat\\ for\\ Windows/SLiteChat\\ -\\ Text-based\\ IM\\ client\\ for\\ Second\\ Life.lnk" },
   { "Soldier of Fortune", "env WINEPREFIX='/home/burchettm/.wineprefix/SOF' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/SOF/dosdevices/c:/users/Public/Start\\ Menu/Programs/Raven\\ Software/Soldier\\ of\\ Fortune\\ Platinum/Soldier\\ of\\ Fortune\\ Platinum.lnk" },
   { "Snowglobe 1.3", "snowglobe" },
   { "Steam", "env WINEPREFIX='/home/burchettm/.wineprefix/Steam' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Steam/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Steam/Steam.lnk" },
   { "Strike Force 181", "env WINEPREFIX='/home/burchettm/.wineprefix/UT' wine C:\\\\unrealtournament\\\\System\\\\Strike\\ Force.exe" },
   { "SuperTuxKart", "/usr/bin/supertuxkart --log=file" },
   { "PyLoTRO", "pylotro" },
   { "UT2004", "env WINEPREFIX='/home/burchettm/.wineprefix/UT' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/UT/dosdevices/c:/users/Public/Start\\ Menu/Programs/Unreal\\ Tournament\\ 2004/Play\\ UT2004.lnk" },
   { "UTGOTY", "env WINEPREFIX='/home/burchettm/.wineprefix/UT' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/UT/dosdevices/c:/users/Public/Start\\ Menu/Programs/Unreal\\ Tournament\\ G.O.T.Y.\\ Edition/Play\\ Unreal\\ Tournament.lnk" },
   { "World of Padman", "worldofpadman" },
   { "WoW-Cataclysm", "wine '/media/Terabyte/WoW-Cataclysm/Launcher.exe" },
   { "WoW-PTR", "env WINEPREFIX='/home/burchettm/.wine' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wine/dosdevices/c:/users/Public/Start\\ Menu/Programs/World\\ of\\ Warcraft\\ Public\\ Test/World\\ of\\ Warcraft.lnk" },
   { "WoW-WotLK", "wine '/media/Terabyte/WoW-WoTLK/Wow.exe'" }
}

mygraphicsmenu = {
   { "Adobe ImageReady 7.0", "env WINEPREFIX='/home/burchettm/.wineprefix/Adobe' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Adobe/dosdevices/c:/users/Public/Start\\ Menu/Programs/Adobe\\ ImageReady\\ 7.0.lnk" },
   { "Adobe PhotoShop 7.0", "env WINEPREFIX='/home/burchettm/.wineprefix/Adobe' wine '/home/burchettm/.wineprefix/Adobe/drive_c/Program Files/Adobe/Photoshop 7.0/Photoshop.exe'" },
   { "Dreamweaver 8", "env WINEPREFIX='/home/burchettm/.wineprefix/Adobe' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Adobe/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Macromedia/Macromedia\\ Dreamweaver\\ 8.lnk" },
   { "IconsExtract", "env WINEPREFIX='/home/burchettm/.wine' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wine/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/NirSoft\\ IconsExtract/IconsExtract.lnk" },
   { "GIMP", "gimp-2.6" },
   { "LXDE Image Viewer", "gpicview" },
   { "MCEdit", "python26 -O '/home/burchettm/Apps/MCEdit-linux/MCEditData/mcedit.pyo'" },
   { "MS Paint", "env WINEPREFIX='/home/burchettm/.wine' wine '/home/burchettm/.wine/drive_c/windows/mspaint.exe'" },
}

myinternetmenu = {
   { "Avahi SSH", "/usr/bin/bssh" },
   { "Avahi VNC", "/usr/bin/bvnc" },
   { "Chromium", "chromium" },
   { "Curse Client", "env WINEPREFIX='/home/burchettm/.wineprefix/Curse' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Curse/dosdevices/c:/users/Public/Start\\ Menu/Programs/Curse/Curse\\ Client.lnk" },
   { "Deluge", "deluge-gtk" },
   { "Dropbox", "/opt/dropbox/dropboxd" },
   { "FileZilla", "filezilla" },
   { "Firefox", "firefox" },
   { "Links", "xlinks -g" },
   { "Mangler", "mangler" },
   { "Midori", "midori" },
   { "Mitter", "/usr/bin/mitter" },
   { "MS RDP", "env WINEPREFIX='/home/burchettm/.wine' wine '/home/burchettm/.wine/drive_c/Program Files/RDP/mstsc.exe'" },
   { "NeverNote", "/usr/share/nevernote/nevernote.sh" },
   { "Opera", "/usr/bin/opera" },
   { "Pidgin", "pidgin" },
   { "qBittorent", "qbittorrent" },
   { "QuickSynergy", "quicksynergy" },
   { "SeaMonkey", "seamonkey" },
   { "Skype", "skype" },
   { "TeamSpeak 3", "/usr/bin/teamspeak3" },
   { "TeamViewer", "/opt/teamviewer/teamviewer/6/bin/teamviewer" },
   { "Thunderbird", "thunderbird" },
   { "Transmission", "transmission-gtk" },
   { "Turpial", "turpial" },
   { "TweetDeck", "adobe-air /opt/tweetdeck/tweetdeck.air" },
   { "WhizNet", "env WINEPREFIX='/home/burchettm/.wineprefix/Whizkid' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Whizkid/dosdevices/c:/users/Public/Start\\ Menu/Programs/Whizkid\\ Online/WhizNet/WhizNet.lnk" },
   { "Wicd", "/usr/bin/wicd-client" }
}

myofficemenu = {
   { "Dictionary", "xfce4-dict" },
   { "Orage Calendar", "orage" },
   { "Orage Globaltime", "globaltime" },
   { "PDF Viewer", "epdfview" }
}

myprogrammingmenu = {
   { "Android SDK", "android" },
   { "CMake", "cmake-gui" },
   { "Dreamweaver 8", "env WINEPREFIX='/home/burchettm/.wineprefix/Adobe' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/Adobe/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Macromedia/Macromedia\\ Dreamweaver\\ 8.lnk" },
   { "Glade", "glade" },
   { "Google Gadget Designer", "/usr/bin/ggl-gtk -sa -nd -gp /usr/share/google-gadgets/designer.gg" },
   { "Qt Assistant", "/usr/bin/assistant" },
   { "Qt Designer", "/usr/bin/designer" },
   { "Qt Linguist", "/usr/bin/linguist" }
}

mysoundmenu = {
   { "AcetoneISO", "acetoneiso" },
   { "Audacious", "audacious" },
   { "Cheese", "cheese" },
   { "dvd::rip", "/usr/bin/vendor_perl/dvdrip" },
   { "EasyTAG", "easytag" },
   { "Ex Falso", "exfalso" },
   { "GNOME MPlayer", "gnome-mplayer" },
   { "GNOME MPC", "gmpc" },
   { "Goggles Music Manger", "gogglesmm" },
   { "GTK-RecordMyDesktop", "gtk-recordmydesktop" },
   { "HandBrake", "ghb" },
   { "Last.FM", "lastfm" },
   { "Mixer", "xfce4-mixer" },
   { "Nero Linux", "nero" },
   { "Nero Linux Express", "neroexpress" },
   { "Pithos", "pithos" },
   { "QT V4L2 Tester", "qv4l2" },
   { "Quod Libet", "quodlibet" },
   { "Sonata", "sonata" },
   { "VLC", "vlc" },
   { "VolWheel", "volwheel" },
   { "Webcam Application", "wxcam" },
   { "XBMC", "xbmc" },
   { "Xfburn", "xfburn" }
}

mysystemtoolsmenu = {
   { "Avahi Zeroconf", "/usr/bin/avahi-discover" },
   { "Bulk Rename", "/usr/lib/Thunar/ThunarBulkRename" },
   { "Cairo-Dock", "cairo-dock -c" },
   { "GLX-Dock", "cairo-dock -o" },
   { "GParted", "gksu /usr/sbin/gparted" },
   { "LXDE Task Manager", "lxtask" },
   { "Manage Printing", "/usr/bin/xdg-open http://localhost:631/" },
   { ".NET 1.1 Configuration", "env WINEPREFIX='/home/burchettm/.wineprefix/SOF' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/SOF/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Administrative\\ Tools/Microsoft\\ .NET\\ Framework\\ 1.1\\ Configuration.lnk" },
   { ".NET 1.1 Wizards", "env WINEPREFIX='/home/burchettm/.wineprefix/SOF' wine C:\\\\windows\\\\command\\\\start.exe /Unix /home/burchettm/.wineprefix/SOF/dosdevices/c:/users/burchettm/Start\\ Menu/Programs/Administrative\\ Tools/Microsoft\\ .NET\\ Framework\\ 1.1\\ Wizards.lnk" },
   { "PkgBrowser", "pkgbrowser" },
   { "RXVT-Unicode", "urxvt" },
   { "Terminal", "terminal" },
   { "Thunar", "Thunar" },
   { "UNetBootIn", "/usr/bin/unetbootin" },
   { "VMware Player", "/usr/bin/vmplayer" },
   { "VMware Workstation", "/usr/bin/vmware" },
   { "VirtualBox", "VirtualBox" },
   { "Virtual Network Editor", "/usr/bin/vmware-netcfg" },
   { "Wireshark", "Wireshark" },
   { "XFCE Task Manager", "xfce4-taskmanager" }
}

mymainmenu = awful.menu({ items = { { " ", " " },
                                    { "Opera", "opera" },
                                    { "Pidgin", "pidgin" },
                                    { "Skype", "skype" },
                                    { "Sonata", "sonata" },
                                    { "TeamSpeak3", "teamspeak3" },
                                    { "Terminal", terminal },
                                    { "Thunderbird", "thunderbird" },
                                    { "Turpial", "turpial" },
                                    { "VirtualBox", "VirtualBox" },
                                    { " ", " " },
                                    { "Accessories", myaccessoriesmenu, beautiful.menu_accessories },
                                    { "Arch Linux" , myarchmenu, beautiful.arch_icon },
                                    { "Games", mygamesmenu, beautiful.menu_games },
                                    { "Graphics", mygraphicsmenu, beautiful.menu_graphics },
                                    { "Internet", myinternetmenu, beautiful.menu_internet },
                                    { "Office", myofficemenu, beautiful.menu_office },
                                    { "Programming", myprogrammingmenu, beautiful.menu_programming },
                                    { "Sound & Video", mysoundmenu, beautiful.menu_sound },
                                    { "System Tools", mysystemtoolsmenu, beautiful.menu_system },
                                    { " ", " " },
                                    { "Awesome", myawesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.arch_icon),
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
cal.register(mytextdate, "<b>%s</b>") -- Added Calendar tooltip to date, bolded day

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
    awful.key({}, "Print", function () awful.util.spawn("scrotshooter") end),
    awful.key({}, "Alt_Sys_Req", function () awful.util.spawn("scrotshooter-aprint") end),
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+") end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-") end),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),
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


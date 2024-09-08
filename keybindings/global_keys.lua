local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local config = require("config.config")

local terminal = config.terminal
local modkey = config.modkey

local powermenu = require("ui.popups.powermenu")

local globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- navigation between workspaces
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	-- navigation between windows
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	-- awful.key({ modkey }, "w", function()
	-- 	launcher_menu:show()
	-- end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Layout size manipulation
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	-- type layout manipulation
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	-- Special OS actions
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- ALSA volume control
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("amixer -q sset Master 5%+", false)
		awesome.emit_signal("volume_change")
	end, { description = "volume up", group = "hotkeys" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("amixer -q sset Master 5%-", false)
		awesome.emit_signal("volume_change")
	end, { description = "volume down", group = "hotkeys" }),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer -q sset Master toggle", false)
		awesome.emit_signal("volume_change")
	end, { description = "toggle mute", group = "hotkeys" }),

	awful.key({ modkey, "Shift", "Control" }, "r", function()
		awful.spawn("amixer -q sset Master 5%+", false)
		awesome.emit_signal("volume_change")
	end, { description = "volume up", group = "hotkeys" }),
	awful.key({ modkey, "Shift", "Control" }, "e", function()
		awful.spawn("amixer -q sset Master 5%-", false)
		awesome.emit_signal("volume_change")
	end, { description = "volume down", group = "hotkeys" }),
	awful.key({ modkey, "Shift", "Control" }, "t", function()
		awful.spawn("amixer -q sset Master toggle", false)
		awesome.emit_signal("volume_change")
	end, { description = "toggle mute", group = "hotkeys" }),

	-- Prompt
	-- awful.key({ modkey }, "r", function()
	-- 	awful.screen.focused().mypromptbox:run()
	-- end, { description = "run prompt", group = "launcher" }),

	-- awful.key({ modkey }, "x", function()
	-- 	awful.prompt.run({
	-- 		prompt = "Run Lua code: ",
	-- 		textbox = awful.screen.focused().mypromptbox.widget,
	-- 		exe_callback = awful.util.eval,
	-- 		history_path = awful.util.get_cache_dir() .. "/history_eval",
	-- 	})
	-- end, { description = "lua execute prompt", group = "awesome" }),

	-- CUSTOM GLOBAL KEYS
	-- Menubar
	awful.key({ modkey }, "p", function()
		awful.spawn("rofi -show drun")
	end, { description = "show app launcher", group = "launcher" }),
	awful.key({ modkey }, "a", function()
		awful.spawn("rofi -show window")
	end, { description = "show windows opened", group = "launcher" }),

	-- Screenshot
	awful.key({ modkey, "Shift" }, "s", function()
		awful.util.spawn("flameshot gui")
	end, { description = "take a screenshot", group = "customs" }),

	-- File manager
	awful.key({ modkey }, "e", function()
		awful.util.spawn("kitty yazi")
	end, { description = "Open file manager (terminal)", group = "customs" }),

	-- Power menu
	awful.key({ modkey, "Shift" }, "q", function()
		powermenu.visible = not powermenu.visible
	end, { description = "Show powermenu", group = "awesome" })
)

return globalkeys

-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")
require("awful.autofocus")

local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end

beautiful.init("~/.config/awesome/theme/theme.lua")

local config = require("config.config")
local terminal = config.terminal

menubar.utils.terminal = terminal

-- define layout avalaible
require("config.layout")

require("ui.screen_setup")

require("keybindings.global_key_setter")
require("keybindings.mouse_keys")

require("config.client_config")

require("ui.popups.volume")
require("ui.titlebar")

-- Custom configuration
beautiful.useless_gap = 7

-- Startup applications
awful.spawn.with_shell("picom -b")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("nm-applet")

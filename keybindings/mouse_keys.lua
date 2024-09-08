local gears = require("gears")
local awful = require("awful")

local launcher_menu = require("ui.popups.launcher_menu")

root.buttons(gears.table.join(
	awful.button({}, 3, function()
		launcher_menu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

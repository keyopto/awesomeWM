local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	local top_titlebar = awful.titlebar(c, {
		height = 20,
		size = 30,
		position = "left",
		bg_normal = beautiful.background_dark,
		-- bg_normal = '#00001180',
		bg_focus = beautiful.background_dark,
		-- bg_focus  = '#00000099',
	})

	top_titlebar:setup({
		{
			{
				awful.titlebar.widget.closebutton(c),
				awful.titlebar.widget.maximizedbutton(c),
				awful.titlebar.widget.minimizebutton(c),
				spacing = 5,
				layout = wibox.layout.fixed.vertical(),
			},
			widget = wibox.container.margin,
			top = 5,
			bottom = 0,
			right = 6,
			left = 3,
		},
		{
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{
			{
				awful.titlebar.widget.stickybutton(c),
				layout = wibox.layout.fixed.vertical(),
			},
			widget = wibox.container.margin,
			top = 0,
			bottom = 5,
			right = 6,
			left = 3,
		},
		layout = wibox.layout.align.vertical,
	})
end)

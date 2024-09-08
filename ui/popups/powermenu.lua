local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local config = require("config.config")
local dpi = beautiful.xresources.apply_dpi

local size_image = dpi(120)
local size_margin_image = dpi(20)
local screen = awful.screen.focused()

local Separator = wibox.widget.textbox("    ")
Separator.forced_height = dpi(1080)
Separator.forced_width = dpi(1920)

local function create_button(command, active_image, inactive_image)
	local image = wibox.widget({
		widget = wibox.widget.imagebox,
		image = beautiful[inactive_image],
		resize = true,
		opacity = 1,
	})

	local button = wibox.widget({
		{
			image,
			left = size_margin_image,
			right = size_margin_image,
			top = size_margin_image,
			bottom = size_margin_image,
			widget = wibox.container.margin,
		},
		shape = gears.shape.rounded_rect,
		widget = wibox.container.background,
		forced_width = size_image,
		forced_height = size_image,
		border_width = dpi(5),
		bg = beautiful.background_powermenu,
	})

	--Functionality
	button:connect_signal("mouse::enter", function()
		-- button.border_color = hover_color
		image.image = beautiful[active_image]
		-- text:set_markup_silently('<span color="' ..
		-- 	hover_color .. '" font="Ubuntu Nerd Font bold 28">' .. description .. '</span>')
	end)
	--
	button:connect_signal("mouse::leave", function()
		-- buttons.border_color = color.grey
		image.image = beautiful[inactive_image]
		-- text:set_markup_silently('<span color="' ..
		-- 	color.white .. '" font="Ubuntu Nerd Font 28">' .. " " .. '</span>')
	end)

	button:connect_signal("button::press", function(_, _, _, button_fun)
		if button_fun == 1 then
			image.image = beautiful[inactive_image]
			awesome.emit_signal("widget::powermenu")

			if active_image == "logout_active" then
				awesome.quit()
				return
			end
			awful.spawn.with_shell(command)
		end
	end)

	return button
end

local powermenu = awful.popup({
	screen = screen,
	widget = wibox.container.background,
	ontop = true,
	bg = "#0000000000",
	visible = false,
	placement = function(c)
		awful.placement.centered(c, {
			margins = {
				top = dpi(0),
				bottom = dpi(0),
				right = dpi(0),
				left = dpi(0),
			},
		})
	end,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 0)
	end,
	opacity = 1,
	forced_height = dpi(1080),
	forced_width = dpi(1920),
})

powermenu:setup({
	{
		Separator,
		{
			{
				{
					create_button(config.logoff_command, "logoff_active", "logoff_inactive"),
					create_button("", "logout_active", "logout_inactive"),
					create_button(config.lock_command, "lock_active", "lock_inactive"),
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.background,
				bg = beautiful.background_powermenu,
				shape = gears.shape.rounded_rect,
			},
			layout = wibox.container.place,
		},
		layout = wibox.layout.stack,
	},
	widget = wibox.container.background,
	bg = beautiful.background_dark .. "33",
})

awesome.connect_signal("widget::powermenu", function()
	powermenu.visible = false
end)

return powermenu

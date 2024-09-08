local gears = require("gears")
local awful = require("awful")

local config = require("config.config")

require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")

local my_launcher_menu = require("ui.popups.launcher_menu")

local mylauncher = awful.widget.launcher({
	image = beautiful.launcher_icon,
	source_width = 20,
	source_height = 20,
	menu = my_launcher_menu,
})

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

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

local function create_prompt_box()
	return awful.widget.prompt()
end

-- a button that tells in which layout (float, tall etc.) you are
local function create_layout_button(s)
	local layout_box = awful.widget.layoutbox(s)
	layout_box:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	return layout_box
end

local function create_tag_list(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = gears.shape.rounded_bar,
			font = config.font_bold("20"),
			fg_focus = "#ff5733",
			bg_focus = "#dddddd",
		},
		layout = {
			spacing = 20,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				id = "text_role",
				widget = wibox.widget.textbox,
				align = "center",
				valign = "center",
			},
			id = "background_role",
			widget = wibox.container.background,
			forced_width = 70,
		},
		buttons = taglist_buttons,
	})
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)

	awful.tag(config.tags, s, awful.layout.layouts[1])

	s.prompt_box = create_prompt_box()
	s.layout_box = create_layout_button(s)
	s.tag_list = create_tag_list(s)
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		-- filter = awful.widget.tasklist.filter.currenttags,
		-- buttons = tasklist_buttons
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = 35,
		opacity = 1,
		stretch = true,
		width = 200,
		bg = "transparent",
		border_width = 5,
		border_color = "transparent",
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			{
				{
					layout = wibox.layout.fixed.horizontal,
					mylauncher,
					mytextclock,
				},
				margins = 5,
				widget = wibox.container.margin,
			},
			bg = "#1A120B",
			opacity = 0.8,
			shape = gears.shape.rounded_bar,
			widget = wibox.container.background,
		},
		{
			s.tag_list,
			bg = "#1A120B",
			opacity = 0.8,
			shape = gears.shape.rounded_bar,
			widget = wibox.container.background,
		},
		{
			{
				{
					layout = wibox.layout.fixed.horizontal,
					mykeyboardlayout,
					wibox.widget.systray(),
					s.layout_box,
				},
				margins = 5,
				widget = wibox.container.margin,
			},
			bg = "#1A120B",
			shape = gears.shape.rounded_bar,
			widget = wibox.container.background,
		},
	})
end)

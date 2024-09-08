---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

theme.font = "JetBrainsMono Medium 8"

theme.bg_normal = "#222222"
theme.bg_focus = "#535d6c"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(0)
theme.border_width = dpi(1)
theme.border_normal = "#000000"
theme.border_focus = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/images/others/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/images/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "~/.config/awesome/images/icons/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = "~/.config/awesome/images/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = "~/.config/awesome/images/icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/images/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "~/.config/awesome/images/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/images/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "~/.config/awesome/images/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/images/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "~/.config/awesome/images/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/images/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "~/.config/awesome/images/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/images/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "~/.config/awesome/images/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/images/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "~/.config/awesome/images/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive =
	"~/.config/awesome/images/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "~/.config/awesome/images/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/images/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "~/.config/awesome/images/icons/titlebar/maximized_focus_active.png"

theme.wallpaper = "~/.config/awesome/images/others/background.jpeg"
-- theme.wallpaper = "~/.config/awesome/images/others/background-pro.jpg"
theme.lock_screen = "~/.config/awesome/images/others/lock_screen.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/images/icons/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/images/icons/layouts/fairvw.png"
theme.layout_floating = "~/.config/awesome/images/icons/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/images/icons/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/images/icons/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/images/icons/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/images/icons/layouts/tilebottomw.png"
theme.layout_tileleft = "~/.config/awesome/images/icons/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/images/icons/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/images/icons/layouts/tiletopw.png"
theme.layout_spiral = "~/.config/awesome/images/icons/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/images/icons/layouts/dwindlew.png"
theme.layout_cornernw = "~/.config/awesome/images/icons/layouts/cornernww.png"
theme.layout_cornerne = "~/.config/awesome/images/icons/layouts/cornernew.png"
theme.layout_cornersw = "~/.config/awesome/images/icons/layouts/cornersww.png"
theme.layout_cornerse = "~/.config/awesome/images/icons/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- launcher icon
theme.launcher_icon = "~/.config/awesome/images/icons/dice-twenty.svg"

-- volume icon
theme.volume = "~/.config/awesome/images/icons/guitar.png"
theme.volume_high = "~/.config/awesome/images/icons/bagpipe.png"
theme.volume_low = "~/.config/awesome/images/icons/ocarina.png"
theme.volume_mute = "~/.config/awesome/images/icons/spirit.png"

-- powermenu icon
theme.logoff_active = "~/.config/awesome/images/icons/powermenu/logoff-active.png"
theme.logoff_inactive = "~/.config/awesome/images/icons/powermenu/logoff-inactive.png"
theme.logout_active = "~/.config/awesome/images/icons/powermenu/logout-active.png"
theme.logout_inactive = "~/.config/awesome/images/icons/powermenu/logout-inactive.png"
theme.lock_active = "~/.config/awesome/images/icons/powermenu/lock-active.png"
theme.lock_inactive = "~/.config/awesome/images/icons/powermenu/lock-inactive.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.background_dark = "#1a1b26"
theme.background_powermenu = "#aeafb1"

return theme

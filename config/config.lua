return {
	modkey = "Mod4",
	terminal = "kitty",
	lock_command = "i3lock -i ~/.config/awesome/images/others/lock_screen.png",
	logoff_command = "shutdown -h now",
	tags = { "󰈹", "", "", "4", "5", "6", "", "󰙯", "" },
	font_bold = function(font_size)
		return "JetBrainsMono Bold " .. font_size
	end,
}

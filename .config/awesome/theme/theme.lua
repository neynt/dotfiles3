local local_path = require("gears.filesystem").get_configuration_dir() .. 'theme/'
local themes_path = require("gears.filesystem").get_themes_dir()
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

-- Main
local theme = {}

-- Misc
theme.wallpaper = local_path .. "background.png"
theme.font = "Fira Sans Condensed Book 9.5"
theme.tasklist_disable_icon = true

local xbackground = xrdb.background
local xforeground = xrdb.foreground
local xcolor0 = xrdb.color0
local xcolor1 = xrdb.color1
local xcolor2 = xrdb.color2
local xcolor3 = xrdb.color3
local xcolor4 = xrdb.color4
local xcolor5 = xrdb.color5
local xcolor6 = xrdb.color6
local xcolor7 = xrdb.color7
local xcolor8 = xrdb.color8
local xcolor9 = xrdb.color9
local xcolor10 = xrdb.color10
local xcolor11 = xrdb.color11
local xcolor12 = xrdb.color12
local xcolor13 = xrdb.color13
local xcolor14 = xrdb.color14
local xcolor15 = xrdb.color15

-- Colors
theme.fg_normal  = xcolor15 .. 'cc'
theme.fg_focus   = xcolor15 .. 'cc'
theme.fg_urgent  = xcolor1 .. 'cc'
theme.bg_normal  = 'transparent'
theme.bg_focus   = 'transparent'
theme.bg_urgent  = xcolor1
theme.bg_systray = '#2d2d2d00'
theme.border_radius = dpi(5)
theme.systray_icon_spacing = dpi(2)

-- Borders
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_normal = xcolor0
theme.border_focus  = xcolor8
theme.border_marked = xcolor1

-- Titlebars
theme.titlebar_bg_focus  = xbackground
theme.titlebar_fg_focus  = xcolor7
theme.titlebar_bg_normal = xbackground
theme.titlebar_fg_normal = xcolor8

-- Menubar
theme.menubar_bg_normal = 'transparent'
theme.menubar_fg_normal = xcolor7
theme.menubar_bg_focus = 'transparent'
theme.menubar_fg_focus = xforeground

-- Other variables:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]

-- Menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(25)
theme.menu_width  = dpi(120)

-- Wibar
theme.wibar_height = dpi(20)
theme.wibar_bg = 'transparent'

-- Tasklist
theme.tasklist_fg_normal = xcolor8
theme.tasklist_fg_focus = xcolor7

-- Notifications
theme.notification_border_width = dpi(1)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.border_focus
theme.notification_bg = xbackground
theme.notification_fg = xcolor7
theme.notification_margin = dpi(12)
theme.notification_padding = dpi(30)
theme.notification_font = theme.font

-- Icons
theme.taglist_squares_sel         = local_path .. "taglist/squares_sel.png"
theme.taglist_squares_unsel       = local_path .. "taglist/squares_unsel.png"
theme.taglist_squares_sel_empty   = local_path .. "taglist/squares_sel_empty.png"
theme.taglist_squares_unsel_empty = local_path .. "taglist/squares_unsel_empty.png"
--theme.taglist_squares_resize = "false"

theme.awesome_icon           = local_path .. "awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"

theme.layout_tile       = local_path .. "layouts/tile.png"
--theme.layout_tileleft   = local_path .. "layouts/tileleft.png"
--theme.layout_tilebottom = local_path .. "layouts/tilebottom.png"
--theme.layout_tiletop    = local_path .. "layouts/tiletop.png"
--theme.layout_fairv      = local_path .. "layouts/fairv.png"
--theme.layout_fairh      = local_path .. "layouts/fairh.png"
--theme.layout_spiral     = local_path .. "layouts/spiral.png"
--theme.layout_dwindle    = local_path .. "layouts/dwindle.png"
--theme.layout_max        = local_path .. "layouts/max.png"
--theme.layout_fullscreen = local_path .. "layouts/fullscreen.png"
--theme.layout_magnifier  = local_path .. "layouts/magnifier.png"
theme.layout_floating   = local_path .. "layouts/floating.png"
--theme.layout_cornernw   = local_path .. "layouts/cornernw.png"
--theme.layout_cornerne   = local_path .. "layouts/cornerne.png"
--theme.layout_cornersw   = local_path .. "layouts/cornersw.png"
--theme.layout_cornerse   = local_path .. "layouts/cornerse.png"

theme.titlebar_close_button_focus  = local_path .. "titlebar/close_focus.png"
theme.titlebar_close_button_normal = local_path .. "titlebar/close_normal.png"
theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_focus_active  = local_path .. "titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = local_path .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = local_path .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = local_path .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active  = local_path .. "titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = local_path .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = local_path .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = local_path .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active  = local_path .. "titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = local_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = local_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = local_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active  = local_path .. "titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = local_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = local_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = local_path .. "titlebar/maximized_normal_inactive.png"

return theme

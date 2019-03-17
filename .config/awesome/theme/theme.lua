-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local local_path = require("gears.filesystem").get_configuration_dir() .. 'theme/'
local themes_path = require("gears.filesystem").get_themes_dir()
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = local_path .. "background.png"
-- }}}

-- {{{ Styles
theme.font = "Fira Sans Condensed Book 9.5"

-- {{{ Colors
theme.fg_normal  = "#828F9E"
theme.fg_focus   = "#D1DDEB"
theme.fg_urgent  = "#CC9393"
theme.bg_normal  = "#2F343F"
theme.bg_focus   = "#2F343F"
theme.bg_urgent  = "#2F343F"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_normal = "#2F343F"
theme.border_focus  = "#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#2F343F"
theme.titlebar_bg_normal = "#2F343F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

theme.tasklist_disable_icon = true

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(25)
theme.menu_width  = dpi(120)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = local_path .. "taglist/squarefz.png"
theme.taglist_squares_unsel = local_path .. "taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = local_path .. "awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = local_path .. "layouts/tile.png"
theme.layout_tileleft   = local_path .. "layouts/tileleft.png"
theme.layout_tilebottom = local_path .. "layouts/tilebottom.png"
theme.layout_tiletop    = local_path .. "layouts/tiletop.png"
theme.layout_fairv      = local_path .. "layouts/fairv.png"
theme.layout_fairh      = local_path .. "layouts/fairh.png"
theme.layout_spiral     = local_path .. "layouts/spiral.png"
theme.layout_dwindle    = local_path .. "layouts/dwindle.png"
theme.layout_max        = local_path .. "layouts/max.png"
theme.layout_fullscreen = local_path .. "layouts/fullscreen.png"
theme.layout_magnifier  = local_path .. "layouts/magnifier.png"
theme.layout_floating   = local_path .. "layouts/floating.png"
theme.layout_cornernw   = local_path .. "layouts/cornernw.png"
theme.layout_cornerne   = local_path .. "layouts/cornerne.png"
theme.layout_cornersw   = local_path .. "layouts/cornersw.png"
theme.layout_cornerse   = local_path .. "layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
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
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

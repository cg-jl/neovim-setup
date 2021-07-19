local utils = require("utils")
local function nvim_tree_options(opts)
  return utils["set-globals"](utils["prefix-options"]({"nvim", "tree"}, opts))
end
nvim_tree_options({add_trailing = 1, auto_close = 1, auto_open = 1, disable_netrw = 1, follow = 1, git_hl = 1, hide_dotfiles = 0, hijack_netrw = 1, ignore = {".git", ".node_modules", ".cache"}, indent_markers = 1, quit_on_open = 1, show_icons = {files = 0, folders = 0, git = 1}, side = "left", tree_icons = {default = "\238\152\146 ", folder = {default = "\238\151\191 ", empty = "\239\132\148 ", empty_open = "\239\132\149 ", open = "\238\151\190 ", symlink = "\239\146\130 ", symlink_open = "\238\151\190 "}, git = {renamed = "\226\158\156 ", staged = "\226\156\147 ", unmerged = "\238\156\167 ", unstaged = "\226\156\151 ", untracked = "\226\152\133 "}, symlink = "\239\146\129 "}, width = 30, width_allow_resize = 1})
return nil

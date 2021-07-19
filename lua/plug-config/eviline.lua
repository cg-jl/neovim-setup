local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
local colors = {bg = "#282828", blue = "#83a598", cyan = "#8ec07c", darkblue = "#458588", fg = "#ebdbb2", green = "#b8bb26", magenta = "#d3869b", orange = "#fe8019", red = "#fb4934", violet = "#b16286", yellow = "#fabd2f"}
local function add_section(name, value)
  return table.insert(gls[name], value)
end
gl["short_line_list"] = {"NvimTree", "packer"}
local function _0_()
  return "\226\150\138 "
end
add_section("left", {RainbowRed = {highight = {colors.darkblue, colors.bg}, provider = _0_}})
local function _1_()
  local mode_color = {R = colors.violet, Rv = colors.violet, S = colors.orange, V = colors.blue, ["!"] = colors.red, ["\19"] = colors.orange, ["\22"] = colors.blue, ["r?"] = colors.cyan, c = colors.magenta, ce = colors.red, cv = colors.red, i = colors.green, ic = colors.yellow, n = colors.red, no = colors.red, r = colors.cyan, rm = colors.cyan, s = colors.orange, t = colors.red, v = colors.blue}
  vim.api.nvim_command(("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()]))
  return "\239\140\140  "
end
add_section("left", {ViMode = {highlight = {colors.red, colors.bg, "bold"}, provider = _1_}})
add_section("left", {FileSize = {condition = condition.buffer_not_empty, highlight = {colors.fg, colors.bg}, provider = "FileSize"}})
add_section("left", {FileIcon = {condition = condition.buffer_not_empty, highlight = {(require("galaxyline.provider_fileinfo")).get_file_icon_color, colors.bg}, provider = "FileIcon"}})
add_section("left", {FileName = {condition = condition.buffer_not_empty, highlights = {colors.magenta, colors.bg, "bold"}, provider = "FileName"}})
add_section("left", {LineInfo = {highlight = {colors.fg, colors.bg}, provider = "LineColumn", separator = " ", separator_highlight = {"NONE", colors.bg}}})
add_section("left", {PerCent = {highlight = {colors.fg, colors.bg, "bold"}, provider = "LinePercent", separator = " ", separator_highlight = {"NONE", colors.bg}}})
add_section("left", {DiagnosticError = {highlight = {colors.red, colors.bg}, icon = " \239\129\151 ", provider = "DiagnosticError"}})
add_section("left", {DiagnosticWarn = {highlight = {colors.yellow, colors.bg}, icon = " \239\129\177 ", provider = "DiagnosticWarn"}})
add_section("left", {DiagnosticHint = {highlight = {colors.cyan, colors.bg}, icon = " \239\129\170 ", provider = "DiagnosticHint"}})
add_section("left", {DiagnosticInfo = {highlight = {colors.blue, colors.bg}, icon = " \239\129\154 ", provider = "DiagnosticInfo"}})
local function _2_()
  local tbl = {[""] = true, dashboard = true}
  return (tbl[vim.bo.filetype] == nil)
end
add_section("mid", {ShowLspClient = {condition = _2_, highlight = {colors.cyan, colors.bg, "bold"}, icon = "\239\130\133 LSP:", provider = "GetLspClient"}})
add_section("right", {FileEncode = {condition = condition.hide_in_width, highlight = {colors.green, colors.bg, "bold"}, provider = "FileEncode", separator = " ", separator_highlight = {NONE = colors.bg}}})
add_section("right", {FileFormat = {condition = condition.hide_in_width, highlight = {colors.green, colors.bg, "bold"}, provider = "FileFormat", separator = " ", separator_highlight = {"NONE", colors.bg}}})
local function _3_()
  return " \239\145\191 "
end
add_section("right", {GitIcon = {condition = condition.check_git_workspace, highlight = {colors.violet, colors.bg, "bold"}, provider = _3_, separator = " ", separator_highlight = {"NONE", colors.bg}}})
add_section("right", {GitBranch = {condition = condition.check_git_workspace, highlight = {colors.violet, colors.bg, "bold"}, provider = "GitBranch"}})
add_section("right", {DiffAdd = {condition = condition.hide_in_width, highlight = {colors.green, colors.bg}, icon = " \239\131\190 ", provider = "DiffAdd"}})
add_section("right", {DiffModified = {condition = condition.hide_in_width, highlight = {colors.orange, colors.bg}, icon = " \239\167\137", provider = "DiffModified"}})
add_section("right", {DiffRemove = {condition = condition.hide_in_width, highlight = {colors.red, colors.bg}, icon = " \239\133\134 ", provider = "DiffRemove"}})
local function _4_()
  return " \226\150\138"
end
add_section("right", {RainbowBlue = {highlight = {colors.blue, colors.bg}, provider = _4_}})
add_section("short_line_left", {BufferType = {highlight = {colors.blue, colors.bg, "bold"}, provider = "FileTypeName", separator = " ", separator_highlight = {"NONE", colors.bg}}})
add_section("short_line_left", {SFileName = {condition = condition.buffer_not_empty, highlight = {colors.fg, colors.bg, "bold"}, provider = "SFileName"}})
add_section("short_line_right", {BufferIcon = {highlight = {colors.fg, colors.bg}, provider = "BufferIcon"}})
vim.api.nvim_command("hi! StatusLine guifg=#282828")
return nil

local utils = require("utils")
vim.cmd("colorscheme nord")
local options = {italic = 1}
utils["set-globals"](utils["prefix-options"]({"nord"}, options))
return nil

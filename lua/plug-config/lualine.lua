local lualine = require("lualine")
lualine.setup({extensions = {"fzf", "nvim-tree", "fugitive"}, options = {icons_enabled = true, theme = "nord"}, sections = {lualine_c = {{"filename", status = true}}, lualine_x = {"LspStatus", "filetype"}, lualine_y = {}}})
return nil

local utils = require("utils")
utils.options("global", {backup = false, clipboard = "unnamedplus", cmdheight = 2, completeopt = "menuone,noinsert,noselect", encoding = "utf-8", guicursor = "", hidden = true, hlsearch = false, ignorecase = true, laststatus = 2, mouse = "nicr", pumheight = 10, ruler = true, showmode = false, showtabline = 2, smartcase = true, smarttab = true, splitbelow = true, termguicolors = true, timeoutlen = 500, updatetime = 300, wildmode = "list:longest", writebackup = false})
utils.options("window", {conceallevel = 0, cursorline = true, list = true, number = true, relativenumber = true, signcolumn = "number", wrap = false})
utils.options("buffer", {autoindent = true, expandtab = true, shiftwidth = 2, smartindent = true, tabstop = 2})
return nil

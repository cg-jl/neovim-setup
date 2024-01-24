vim.g.mapleader = ","

-- how I want to see vim
vim.go.termguicolors = true
vim.wo.wrap = true
vim.wo.cursorline = true
vim.go.showmode = false
vim.go.laststatus = 0 -- do not show statusline
vim.go.hlsearch = false
vim.wo.signcolumn = "yes:1"

vim.bo.swapfile = false

-- default, with insert changed to underline
vim.go.guicursor = "n-v-c-sm:block,i-ci-ve:ver20,r-cr-o:hor20"

vim.go.winbar = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
vim.go.ruler = false

-- number, relativenumber
vim.wo.nu = true
vim.wo.rnu = true

vim.o.exrc = true

-- splitting
vim.go.splitright = true

-- basic code style
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 80

vim.go.mouse = ""
--vim.go.clipboard = "unnamedplus"

-- no backup files
vim.go.writebackup = false
vim.go.backup = false

-- search & completion from wildmenu
vim.go.smartcase = true
vim.go.ignorecase = true
vim.go.wildmode = "list:longest"
vim.go.completeopt = "menuone,noinsert,noselect"

-- navigation
--   between buffers
vim.keymap.set("n", "t", vim.cmd.bprev)
vim.keymap.set("n", "s", vim.cmd.bnext)
--  qflist
vim.keymap.set("n", "<m-t>", vim.cmd.cprev)
vim.keymap.set("n", "<m-s>", vim.cmd.cnext)
--  loc list
vim.keymap.set("n", "<space>t", vim.cmd.lprev)
vim.keymap.set("n", "<space>s", vim.cmd.lnext)

-- exit normal/visual node
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("v", "jk", "<esc>")

-- easier tabbing in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- save file
vim.keymap.set("n", "<leader>w", vim.cmd.update)

-- lsp keymaps
vim.keymap.set("n", "<space>h", vim.lsp.buf.hover)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<space>f", function()
	vim.lsp.buf.format({ async = true })
end)
vim.keymap.set("n", "<space>m", vim.lsp.buf.rename)
vim.keymap.set("n", "<space>rr", vim.lsp.buf.references)

-- load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "travisjeffery/vim-auto-mkdir" },

	{
		"kepano/flexoki-neovim",
		name = "flexoki",
		enabled = true,
		priority = 1000,
		lazy = false,

		config = function()
			vim.cmd.colorscheme("flexoki-dark")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local ts = require("nvim-treesitter.configs")
			ts.setup({
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "-",
						node_incremental = "-",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				ensure_instaled = { "comment" },
			})
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.jakt = {
				install_info = {
					url = "https://github.com/SerenityOS/tree-sitter-jakt.git", -- local path or git repo
					files = { "src/parser.c", "src/scanner.c" },
					-- optional entries:
					branch = "main", -- default branch in case of git repo if different from master
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
			}
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },

		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forwards to textobj
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							-- useful for changing parameter; cgp
							["gp"] = "@parameter.inner",
							-- useful for deleting paarmeters: d,p (for delete
							-- parameter with comma)
							[",p"] = "@parameter.outer",
						},
					},
				},
			})
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-context", dependencies = "nvim-treesitter/nvim-treesitter" },

	"tpope/vim-commentary",
	"tpope/vim-repeat",
	{ "tpope/vim-fugitive", keys = { {
		"<leader>gs",
		function()
			vim.cmd.Git()
		end,
	} } },

	{
		"nvim-telescope/telescope.nvim",
		pin = true,
		dependencies = { "nvim-telescope/telescope-ui-select.nvim", "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"<leader>rg",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"<leader>l",
				function()
					require("telescope.builtin").jumplist()
				end,
			},
			{
				"<leader>m",
				function()
					require("telescope.builtin").marks()
				end,
			},
		},
		config = function()
			local ts = require("telescope")
			ts.load_extension("ui-select")
			ts.setup({
				-- FIXME: maybe this should go in a different place?
				file_ignore_patterns = { "./toolchains/*", "zig-out", "zig-cache" },
			})
		end,
	},

	-- completion & lsp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"kdheepak/cmp-latex-symbols",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local cmp = require("cmp")

			-- local luasnip = require("luasnip")

			-- luasnip.config.set_config({ enable_autosnippets = true })

			-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip" })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "latex_symbols" },
					{ name = "buffer" },
					{ name = "neorg" },
				},
				mapping = cmp.mapping.preset.insert({
					["<m-m>"] = cmp.mapping.confirm({ select = true }),
					["<m-n>"] = cmp.mapping.complete(),
					["<m-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<m-t>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
			})
		end,
	},

	{ "kylelaker/riscv.vim", ft = "riscv" },

	{
		"lervag/vimtex",
		ft = { "tex", "latex" },
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_forward_search_on_start = 0
		end,
	},
	{ dir = "~/jakt/editors/vim", ft = "jakt", as = "jakt" },

	{
		"neovim/nvim-lspconfig",
		init = function()
			local lsp = require("lspconfig")
			lsp.clangd.setup({})
			lsp.zls.setup({})
			lsp.ols.setup({})
			-- NOTE: for primeagen's DSA course
			lsp.tsserver.setup({})
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.bo[args.buf].formatexpr = nil
	end,
})

-- FIXME: this could probably be somewhere else
require("treesitter-context").setup()

vim.g.mapleader = ","

-- how I want to see vim
vim.cmd.colorscheme("habamax")
vim.wo.wrap = true
vim.go.showmode = false
vim.go.termguicolors = true
vim.go.laststatus = 3
vim.go.hlsearch = false
vim.wo.signcolumn = "yes:1"
-- number, relativenumber
vim.wo.nu = true
vim.wo.rnu = true

-- splitting
vim.go.splitright = true

-- basic code style
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 80

vim.go.mouse = ""
vim.go.clipboard = "unnamedplus"
vim.go.laststatus = 3

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
vim.keymap.set("n", "<space>d", vim.lsp.buf.definition)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action)
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
		"ellisonleao/gruvbox.nvim",
		--'morhetz/gruvbox',
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
		enabled = false,
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				term_colors = true,
				transparent_background = true,
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			local ts = require("nvim-treesitter.configs")
			ts.setup({
				highlight = { enable = true },
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
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,

		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forwards to textobj
						lookahead = true,
						keymaps = {
							-- va=, etc all have their v/c commands
							["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
							["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
							["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
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
			{ "<space>a", vim.lsp.buf.code_action },
			{
				"<leader>ff",
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
				"<leader>bb",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"<leader>jl",
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

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	"chrisbra/unicode.vim",

	-- completion & lsp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"kdheepak/cmp-latex-symbols",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			luasnip.config.set_config({ enable_autosnippets = true })

			-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			-- https://github.com/hrsh7th/nvim-cmp/discussions/702
			do
				local devicons = require("nvim-web-devicons")
				cmp.register_source("devicons", {
					complete = function(self, params, callback)
						local items = {}
						for _, icon in pairs(devicons.get_icons()) do
							table.insert(items, {
								label = icon.icon .. "  " .. icon.name,
								insertText = icon.icon,
								filterText = icon.name,
							})
						end
						callback({ items = items })
					end,
				})
			end

			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip" })
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
					{ name = "emoji" },
					{ name = "neorg" },
					{ name = "devicons" },
				},
				mapping = cmp.mapping.preset.insert({
					["<c-f>"] = cmp.mapping.confirm({ select = true }),
					["<c-space>"] = cmp.mapping.complete(),
					["<c-n>"] = cmp.mapping(function(fallback)
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
					["<c-t>"] = cmp.mapping(function(fallback)
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

	{
		"phaazon/mind.nvim",
		branch = "v2",
		keys = {
			{
				"<leader>mm",
				function()
					require("mind").open_main()
				end,
			},
			{
				"<leader>mp",
				function()
					require("mind").open_project()
				end,
			},
		},
	},

	{ "kylelaker/riscv.vim", ft = "riscv" },
	{ "tjdevries/ocaml.nvim", ft = "ocaml" },

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
			lsp.gopls.setup({})
			lsp.rust_analyzer.setup({})
		end,
	},

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.integrations.nvim-cmp"] = {},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
							name = "neorg",
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/todo",
							},
							default_workspace = "notes",
						},
					},
				},
			})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
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

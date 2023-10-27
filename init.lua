vim.g.mapleader = ","

-- how I want to see vim
vim.cmd.colorscheme("habamax")
vim.wo.wrap = true
vim.go.showmode = true -- currently, until I set up airline
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
vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.textwidth = 80

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
		"catppuccin/nvim",
		as = "catppuccin",
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
	{ "nvim-treesitter/nvim-treesitter" },
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

	"chrisbra/unicode.vim",

	-- completion & lsp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwi1/cmp_luasnip",
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
		end,
	},
})

-- FIXME: this could probably be somewhere else
require("nvim-treesitter.configs").setup({ highlight = { enable = true, indent = { enable = true } } })
require("treesitter-context").setup()

vim.g.mapleader = ","

vim.go.guicursor = "i:block"
vim.go.showmode = false -- using lualine (below)
vim.go.wildmode = "list:longest"
vim.go.backup = false
vim.go.hlsearch = false
vim.go.smartcase = true
vim.go.ignorecase = true
vim.go.termguicolors = true
vim.go.completeopt = "menuone,noinsert,noselect"
vim.go.splitright = true
vim.go.laststatus = 3
vim.go.writebackup = false
vim.go.clipboard = "unnamedplus"
vim.go.mouse = ""
vim.go.bg = "dark"

vim.wo.conceallevel = 0
vim.wo.colorcolumn = "80"
vim.wo.cursorline = false
vim.wo.signcolumn = "yes"
vim.wo.cursorline = true
vim.wo.list = false
vim.wo.number = true
vim.wo.relativenumber = true

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.swapfile = false

-- keys

-- navigation
-- -- buffers
vim.keymap.set("n", "t", ":bprev<cr>")
vim.keymap.set("n", "s", ":bnext<cr>")
-- -- qflist
vim.keymap.set("n", "<m-t>", ":cnext<cr>")
vim.keymap.set("n", "<m-s>", ":cprev<cr>")
-- -- loclist
vim.keymap.set("n", "<space>t", "lcnext<cr>")
vim.keymap.set("n", "<space>s", ":lprev<cr>")
-- :help update
vim.keymap.set("n", "<leader>w", ":update<cr>")

-- merge tooling
vim.keymap.set("n", "gu", ":diffget //2<cr>") -- left hand
vim.keymap.set("n", "gh", ":diffget //3<cr>") -- right hand

-- exit normal/visual mode
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("v", "jk", "<esc>")

-- easier tabbing in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy.nvim
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
	-- automkdir solves all my tree problems :)
	"travisjeffery/vim-auto-mkdir",
	-- colorscheme
	{
		"cocopon/iceberg.vim",
		config = function()
			vim.api.nvim_command([[colorscheme iceberg]])
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
			vim.keymap.set("n", "<leader>lt", ":TodoLocList<cr>")
		end,
	},
	{
		"j-hui/fidget.nvim",
		pin = true,
		config = function()
			require("fidget").setup({
				window = { blend = 10 }, -- required by catppuccin
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		pin = false,
		config = function()
			local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

			parser_configs.zig = {
				install_info = {
					url = "https://github.com/maxxnino/tree-sitter-zig",
					files = { "src/parser.c" },
					revision = "d1df4735c1d7ffc2b38d483347d6eaf7f42e5849",
				},
				filetype = "zig",
				maintainers = { "@maxxnino" },
			}
			parser_configs.jakt = {
				install_info = {
					url = "https://github.com/SerenityOS/tree-sitter-jakt",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "main",
					generate_requires_npm = false,
					-- src/parser.c already generated
					requires_generate_from_grammar = false,
				},
				filetype = "jakt",
				maintainers = { "@demizer" },
			}
			parser_configs.x86asm = {
				install_info = {
					url = "https://github.com/bearcove/tree-sitter-x86asm",
					files = { "src/parser.c" },
					revision = "ca72933e74ea3b3f995bc4b245f03328554f1e65",
				},
				filetype = "asm",
				maintainers = { "@fasterthanlime" },
			}
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup()
		end,
	},

	-- classics
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", ":Git<cr>")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("harpoon")
			vim.keymap.set("n", "<a-n>", function()
				require("harpoon.mark").add_file()
			end)
			vim.keymap.set("n", "<a-m>", ":Telescope harpoon marks<cr>")
		end,
	},

	-- ----------------------------------------
	-- lsp
	{
		"neovim/nvim-lspconfig",
		pin = true,
		dependencies = { "nvim-lua/lsp-status.nvim" },
		config = function()
			local lsp = require("lspconfig")
			local status = require("lsp-status")
			local options = {
				on_attach = status.on_attach,
				capabilities = status.capabilities,
			}

			lsp.rust_analyzer.setup(options)
			lsp.gopls.setup(options)
			lsp.clangd.setup(options)
			lsp.zls.setup(options)
			lsp.jdtls.setup(options)

			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
			vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action)
			vim.keymap.set("v", "<space>a", vim.lsp.buf.code_action)
			vim.keymap.set("n", "<space>d", vim.lsp.buf.definition)
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end)
			vim.keymap.set("n", "<space>h", vim.lsp.buf.hover)
			vim.keymap.set("n", "<space>m", vim.lsp.buf.rename)
			vim.keymap.set("n", "<space>rr", vim.lsp.buf.references)
		end,
	},
	-- java language server
	{ "mfussenegger/nvim-jdtls", lazy = true, ft = "java" },
	{
		"simrat39/rust-tools.nvim",
		lazy = true,
		ft = "rust",
		pin = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local rt = require("rust-tools")

			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<space>h", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<space>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		pin = true,
		config = function()
			local builtin = require("telescope.builtin")
			local ts = require("telescope")

			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>rg", builtin.live_grep)
			vim.keymap.set("n", "<leader>bb", builtin.buffers)
			vim.keymap.set("n", "<leader>jl", builtin.jumplist)
			vim.keymap.set("n", "<leader>m", builtin.marks)

			require("telescope").setup({
				file_ignore_patterns = { "./toolchains/*", "zig-out", "zig-cache" },
			})
		end,
	},

	-- ------------------------------
	-- completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"kdheepak/cmp-latex-symbols", -- μ δ in signals it's really cool
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.set_config({
				enable_autosnippets = true,
			})

			-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
				},
				mapping = cmp.mapping.preset.insert({
					["<c-f>"] = cmp.mapping.confirm({ select = true }),
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

	-- -------------------------------
	-- misc
	{
		"phaazon/mind.nvim",
		branch = "v2",
		config = function()
			local mind = require("mind")
			mind.setup()
			vim.keymap.set("n", "<leader>mm", mind.open_main)
			vim.keymap.set("n", "<leader>mp", mind.open_project)
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
				},
				sections = {
					lualine_a = { { "buffers" } },
					lualine_c = {},
				},
			})
		end,
	},

	-- more language support
	"ARM9/arm-syntax-vim",
	"tikhomirov/vim-glsl",
	"LnL7/vim-nix",
	"kylelaker/riscv.vim",
	-- Whoever made this blog, thanks a ton!
	-- https://www.ejmastnak.com/tutorials/vim-latex/intro.html
	{
		"lervag/vimtex",
		lazy = true,
		ft = { "latex", "tex" },
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_forward_search_on_start = 0
		end,
	},
	{ dir = "~/jakt/editors/vim", as = "jakt", ft = "jakt", lazy = true },
})

local utils = require("settings-utils")
local keys = utils.keys
local options = utils.options

vim.g.mapleader = ","
vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true })

local option = vim.api.nvim_set_option
local function window_option(opt, value)
	vim.wo[opt] = value
	option(opt, value)
end
local function buffer_option(opt, value)
	vim.bo[opt] = value
	option(opt, value)
end

options({
	global = {
		guicursor = "i:block",
		showmode = false,
		wildmode = "list:longest",
		backup = false,
		hlsearch = false,
		smartcase = true,
		ignorecase = true,
		termguicolors = true,
		completeopt = "menuone,noinsert,noselect",
		splitright = true,
		laststatus = 3,
		writebackup = false,
		clipboard = "unnamedplus",
		mouse = "",
		bg = "dark",
	},
	window = {
		conceallevel = 0,
		colorcolumn = "80",
		cursorline = false,
		signcolumn = "yes",
		list = false,
		number = true,
		relativenumber = true,
	},
	buffer = {
		tabstop = 4,
		shiftwidth = 4,
		expandtab = false,
		swapfile = false,
	},
})

keys({
	normal = {
		["t"] = { cmd = "bprev" },
		["s"] = { cmd = "bnext" },

		-- quickfix list
		-- ['<c-j>'] = { cmd = 'cprev' },
		-- ['<c-k>'] = { cmd = 'cnext' },
		["<m-t>"] = { cmd = "cnext"},
		["<m-h>"] = { cmd = "cprev"},
		["<space>t"] = { cmd = "lnext"},
		["<space>s"] = { cmd = "lprev" },
		-- :help update
		["<leader>w"] = { cmd = "update" },
		gu = { cmd = "diffget //2" }, -- left hand
		gh = { cmd = "diffget //3" }, -- right hand
		
	},
	insert = {
		-- classic
		jk = "<esc>",
		-- tab completion
		["<tab>"] = { expr = 'pumvisible() ? "\\<c-n>" : "\\<tab>"' },
	},
	visual = {
		jk = "<esc>",
		-- better tabbing
		["<"] = "<gv",
		[">"] = ">gv",
	},
})

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
	{
		"travisjeffery/vim-auto-mkdir",
	},
	{
		"cocopon/iceberg.vim",
		config = function()
			vim.api.nvim_command([[colorscheme iceberg]])
		end,
	},
	{
		"sainnhe/gruvbox-material",
		pin = true,
		enabled = false,
		config = function()
			local options = require("settings-utils").options
			vim.api.nvim_command([[
let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material
]])
		end,
	},
	{
		"kylelaker/riscv.vim",
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
		pin = true,
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
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
				ensure_installed = {},
				sync_install = false,
				highlight = { enable = true },
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
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{
		"tpope/vim-fugitive",
		config = function()
			require("settings-utils").keys({
				normal = {
					["<leader>gs"] = { cmd = "Git" },
				},
			})
		end,
	},

	-- switch between open files with a couple keys
	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	dependencies = "kyazdani42/nvim-web-devicons",
	-- 	config = function()
	-- 		require("settings-utils").keys({
	-- 			normal = {
	-- 				["<leader>bp"] = { cmd = "BufferPick" },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("harpoon")
			require("settings-utils").keys({
				normal = {
					["<a-n>"] = function()
						require("harpoon.mark").add_file()
					end,
					["<a-t>"] = { cmd = "Telescope harpoon marks" },
				},
			})
		end,
	},

	-- ----------------------------------------
	-- lsp & dap
	{
		"neovim/nvim-lspconfig",
		pin = true,
		dependencies = { "nvim-lua/lsp-status.nvim", "ms-jpq/coq_nvim" },
		config = function()
			local lsp = require("lspconfig")
			local util = require("lspconfig/util")
			local coq = require("coq")
			local status = require("lsp-status")
			local utils = require("settings-utils")
			local options = coq.lsp_ensure_capabilities({
				on_attach = status.on_attach,
				capabilities = status.capabilities,
				settings = {
					rust_analyzer = {
						checkOnSave = { command = "clippy" },
						cargo = { allFeatures = true },
						checkOnSave = { allFeatures = true, extraArgs = { "--all-features" } },
					},
				},
			})

			lsp.rust_analyzer.setup(options)
			lsp.gopls.setup(options)
			lsp.clangd.setup(options)
			lsp.zls.setup(options)
			lsp.ocamllsp.setup(options)
			lsp.jdtls.setup(options)
			lsp.ghdl_ls.setup(options)
			lsp.hls.setup(options)
			lsp.arduino_language_server.setup(options)

			utils.keys({
				normal = {
					["<space>,"] = vim.diagnostic.goto_prev,
					["<space>;"] = vim.diagnostic.goto_next,

					["<space>a"] = vim.lsp.buf.code_action,
					["<space>d"] = vim.lsp.buf.definition,
					["<space>f"] = function()
						vim.lsp.buf.format({ async = true })
					end,
					["<space>h"] = vim.lsp.buf.hover,
					["<space>m"] = vim.lsp.buf.rename,
					["<space>rr"] = vim.lsp.buf.references,
				},
				visual = {
					["<space>a"] = vim.lsp.buf.code_action,
				},
			})
		end,
	},
	{ "mfussenegger/nvim-jdtls", lazy = true, ft = "java" }, -- java language server
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim" },
		pin = true,
		config = function()
			local r = require("refactoring")
			r.setup({})

			local t = require("telescope")
			t.load_extension("refactoring")

			require("settings-utils").keys({
				visual = {
					["<space>rf"] = { cmd = "lua require 'telescope'.extensions.refactoring.refactors()" },
				},
				normal = {
					["<space>rf"] = { cmd = "lua require 'telescope'.extensions.refactoring.refactors()" },
				},
			})
		end,
	},
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
	{ "mfussenegger/nvim-dap", pin = true },
	{ "nvim-telescope/telescope.nvim", pin = true },
	{
		"nvim-telescope/telescope-dap.nvim",
		pin = true,
		dependencies = { "nvim-telescope/telescope.nvim", "theHamsta/nvim-dap-virtual-text" },
		config = function()
			local utils = require("settings-utils")
			local builtin = require("telescope.builtin")
			local dap = require("dap")
			local ts = require("telescope")

			utils.keys({
				normal = {
					-- telescope bindings
					["<leader>ff"] = builtin.find_files,
					["<leader>rg"] = builtin.live_grep,
					["<leader>bb"] = builtin.buffers,
					["<leader>jl"] = builtin.jumplist,
					["<leader>m"] = builtin.marks,

					-- dap bindings
					["<f5>"] = dap.continue,
					["<f10>"] = dap.step_over,
					["<f11>"] = dap.step_into,
					["<s-f11>"] = dap.step_out,
					["<leader>tb"] = dap.toggle_breakpoint,
					["<leader>ctb"] = function()
						dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
					end,
					["<leader>repl"] = dap.repl.open,

					-- telescope-dap bindings
					["<leader>dc"] = ts.extensions.dap.commands,
					["<leader>dlb"] = ts.extensions.dap.list_breakpoints,
					["<leader>var"] = ts.extensions.dap.variables,
				},
			})

			require("telescope").setup({
				file_ignore_patterns = { "./toolchains/*", "zig-out", "zig-cache" },
			})
			require("telescope").load_extension("dap")
			require("nvim-dap-virtual-text").setup()

			local dap = require("dap")
			dap.adapters.lldb = {
				type = "executable",
				command = "/home/gsus/.local/bin/lldb-vscode",
				name = "lldb",
			}

			dap.configurations.rust = {
				{
					name = "Debug Rust",
					type = "lldb",
					request = "launch",
					program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations.zig = {
				{
					name = "Debug Zig Tests",
					type = "lldb",
					request = "launch",
					program = function()
						local current_file = vim.api.nvim_buf_get_name(0)
						local basename = current_file:match("^.*/(.*).zig$")
						local name = "zig-out/bin/" .. basename .. "-test"
						return name
					end,
					args = { "/home/gsus/.local/bin/zig" },
				},
			}
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
			"kdheepak/cmp-latex-symbols",
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
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			local utils = require("settings-utils")
			utils.keys({
				normal = {
					["<leader>ll"] = { cmd = "TroubleToggle" },
					["<leader>lw"] = { cmd = "TroubleWorkspaceToggle" },
					["<leader>ld"] = { cmd = "TroubleDocumentToggle" },
				},
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
			require("settings-utils").keys({
				normal = {
					["<leader>mm"] = function()
						mind.open_main()
					end,
					["<leader>mp"] = function()
						mind.open_project()
					end,
				},
			})
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
					theme = "iceberg",
				},
				sections = {
					lualine_a = {
						{
							"buffers",
						},
					},
					lualine_c = {},
				},
			})
		end,
	},

	-- more language support
	"ARM9/arm-syntax-vim",
	"tikhomirov/vim-glsl",
	"LnL7/vim-nix",
	-- Whoever made this blog, thanks a ton!
	-- https://www.ejmastnak.com/tutorials/vim-latex/intro.html
	{
		"lervag/vimtex",
		lazy = true,
		ft = { "latex", "tex" },
		config = function()
			local utils = require("settings-utils")
			utils.vars({
				vimtex_view_method = "zathura",
				vimtex_view_forward_search_on_start = 0,
			})
		end,
	},
	{ dir = "~/jakt/editors/vim", as = "jakt", ft = "jakt", lazy = true },
	"fladson/vim-kitty",
	"terminalnode/sway-vim-syntax",
})

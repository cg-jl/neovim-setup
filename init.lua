
vim.cmd [[packadd packer.nvim]]
vim.g.mapleader = ','
vim.keymap.set('n', '<leader>w', '<cmd>update<cr>', { silent = true })

local option = vim.api.nvim_set_option
local function window_option(opt, value)
	vim.wo[opt] = value
	option(opt, value)
end
local function buffer_option(opt, value)
	vim.bo[opt] = value
	option(opt, value)
end

local function options(opts)
	for key, value in pairs(opts.global) do
		vim.api.nvim_set_option(key, value)
	end
	for key, value in pairs(opts.window) do
		vim.api.nvim_set_option(key, value)
		vim.wo[key] = value
	end
	for key, value in pairs(opts.buffer) do
		vim.api.nvim_set_option(key, value)
		vim.bo[key] = value
	end
end

local function keys(opts)
    local function map_key(mode, key, obj, opts)
        local rhs = ''
        if type(obj) == 'string' then
            rhs = obj
        elseif obj.expr ~= nil then
            rhs = obj.expr
            opts.expr = true
        elseif obj.cmd ~= nil then
            rhs = '<cmd>' .. obj.cmd .. '<cr>'
            opts.silent = true
        else
            rhs = obj[1]
        end

        vim.keymap.set(mode, key, rhs, opts)
    end

    if opts.visual ~= nil then
        for key, target in pairs(opts.visual) do
            map_key('v', key, target, (type(target) == 'table' and target.opts) or {})
        end
    end
    if opts.insert ~= nil then
        for key, target in pairs(opts.insert) do
            map_key('i', key, target, (type(target) == 'table' and target.opts) or {})
        end
    end
    if opts.normal ~= nil then
        for key, target in pairs(opts.normal) do
            map_key('n', key, target, (type(target) == 'table' and target.opts) or {})
        end
    end
end

options {
	global = {
		guicursor = 'i:block',
		showmode = false,
		wildmode = 'list:longest',
		backup = false,
		hlsearch = false,
		smartcase = true,
		ignorecase = true,
		termguicolors = true,
		completeopt = 'menuone,noinsert,noselect',
		splitright = true,
		laststatus = 3,
		writebackup = false,
		clipboard = 'unnamedplus',
		mouse = 'nicr'
	},
	window = {
		conceallevel = 0,
		cursorline = true,
		signcolumn = 'yes',
		list = false,
		number = true,
		relativenumber = true,
	},
	buffer = {
		tabstop = 4,
		textwidth = 80, -- wrap lines when I'm writing
		shiftwidth = 4,
		expandtab = true,
		swapfile = false,
	}
}

keys {
    normal = {
        -- alt navigation
        ["<m-j>"] = "<c-w>j",
        ['<m-k>'] = '<c-w>k',
        ['<m-h>'] = '<c-w>h',
        ['<m-l>'] = '<c-w>l',
        -- quickfix list
        ['<c-j>'] = { cmd = 'cprev' },
        ['<c-k>'] = { cmd = 'cnext' },
        ['<leader>j'] = { cmd = 'lprev' },
        ['<leader>k'] = { cmd = 'lnext' },
        -- :help update
        ['<leader>w'] = { cmd = 'update' }
    },
    insert = {
        -- classic
        jk = '<esc>',
        -- tab completion
        ['<tab>'] = { expr = 'pumvisible() ? "\\<c-n>" : "\\<tab>"' }
    },
    visual = {
        jk = '<esc>',
        -- better tabbing
        ['<'] = '<gv',
        ['>'] = '>gv'
    }
}

require 'packer'.startup(function()
	use 'wbthomason/packer.nvim'
	use { 'sonph/onehalf',
		rtp = 'vim',
		config = function()
			-- TODO: lightline
			vim.cmd [[
            colorscheme onehalfdark
            hi! Normal guibg=NONE
            ]]
		end
	}
    use { 'nvim-treesitter/nvim-treesitter',
        run = function()
            require 'nvim-treesitter.install'.update { with_sync = true }
        end,
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { 'c', 'lua' },
                sync_install = false,
                highlight = { enable = true }
            }
        end
    }
    -- make stuff transparent :)
    use { 'xiyaowong/nvim-transparent',
        config = function()
            require 'transparent'.setup {
                enable = true,
            }
        end}

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'
    use {
        'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = vim.fn['fzf#install'],
        },
        config = function()
            vim.keymap.set('n', '<leader>ff', '<cmd>Files<cr>')
            vim.keymap.set('n', '<leader>rg', '<cmd>Rg<cr>')
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'nvim-tree'.setup {
                disable_netrw = true,
                hijack_netrw = true
            }
            vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { silent = true})
        end
    }

    -- lsp
    use { 'neovim/nvim-lspconfig',
        requires = { 'nvim-lua/lsp-status.nvim', 'ms-jpq/coq_nvim' },
        config = function()
            local lsp = require 'lspconfig'
            local status = require 'lsp-status'
            local util = require 'lspconfig/util'
            local coq = require 'coq'
            status.register_progress()
            local options = coq.lsp_ensure_capabilities {
                on_attach = status.on_attach,
                capabilities = status.capabilities,
                settings = {
                    rust_analyzer = {
                        checkOnSave = { command = 'clippy' },
                        cargo = { allFeatures = true }
                    }
                }
            }

            lsp.rust_analyzer.setup(options)
            lsp.hls.setup(options)
            lsp.gopls.setup(options)
            lsp.clangd.setup(options)

            vim.keymap.set('n', '<space>,', vim.diagnostic.goto_prev)
            vim.keymap.set('n', '<space>;', vim.diagnostic.goto_next)

            vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action)
            vim.keymap.set('n', '<space>d', vim.lsp.buf.definition)
            vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting)
            vim.keymap.set('n', '<space>h', vim.lsp.buf.hover)
            vim.keymap.set('n', '<space>m', vim.lsp.buf.rename)
            vim.keymap.set('n', '<space>r', vim.lsp.buf.references)
            vim.keymap.set('n', '<space>s', vim.lsp.buf.document_symbol)
        end

    }

    -- completion
    use {
        'hrsh7th/nvim-cmp',
        requires = { 'L3MON4D3/LuaSnip',
                    'saadparwaiz1/cmp_luasnip',
                    'hrsh7th/cmp-nvim-lsp',
                    'hrsh7th/cmp-buffer',
                    'nvim-lua/plenary.nvim'},
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' }
                },
                mapping = cmp.mapping.preset.insert {
                    ["<c-space>"] = cmp.mapping.complete(),
                    ["<cr>"] = cmp.mapping.confirm { select = true }
                }
            }
        end
    }
    use { 'folke/trouble.nvim',
          requires = 'kyazdani42/nvim-web-devicons'}

    -- languages
    use 'ARM9/arm-syntax-vim'
    use { '~/contrib/jakt/editors/vim', as = 'jakt' }
    use 'fladson/vim-kitty'
end)

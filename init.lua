local utils = require 'settings-utils'
local keys = utils.keys
local options = utils.options


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
        cursorline = false,
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
        -- ['<c-j>'] = { cmd = 'cprev' },
        -- ['<c-k>'] = { cmd = 'cnext' },
        -- ['<leader>j'] = { cmd = 'lprev' },
        -- ['<leader>k'] = { cmd = 'lnext' },
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
            vim.cmd [[colorscheme onehalfdark]]
        end,
        disable = true,
    }

    use { 'Shatur/neovim-ayu',
        config = function()
            require 'ayu'.setup {
                mirage = true,
                overrides = {}
            }
            vim.cmd [[colorscheme ayu]]
        end,
        disable = true,
    }

    use { 'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require 'catppuccin'.setup {
                flavour = 'mocha',
                transparent_background = true,
                term_colors = true,
                integrations = {
                    fidget = true,
                    treesitter = true,
                    barbar = true,
                    native_lsp = {
                        enabled = true,
                    },
                    lsp_trouble = true,
                    nvimtree = true,
                    cmp = true,
                }
            }
            vim.api.nvim_command "colorscheme catppuccin"
        end,
    }

    use {'j-hui/fidget.nvim',
        config = function()
            require 'fidget'.setup {
                window = { blend = 0 } -- required by catppuccin
            }
        end,
    }


    use { 'nvim-treesitter/nvim-treesitter',
        run = function()
            require 'nvim-treesitter.install'.update { with_sync = true }
        end,
        config = function()
            local parser_configs = require 'nvim-treesitter.parsers'.get_parser_configs()
                parser_configs.jakt = {
                install_info = {
                    url = "https://github.com/demizer/tree-sitter-jakt",
                    files = { "src/parser.c", "src/scanner.c" },
                    revision = "a65bffd7ab951081c50df41897e850f8b46e0eff",
                },
                filetype = "jakt",
                maintainers = { "@demizer" }
            }
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { 'c', 'lua' },
                sync_install = false,
                highlight = { enable = true }
            }
        end
    }
    use { 'nvim-treesitter/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter', config = function() require 'treesitter-context'.setup() end }
    -- make stuff transparent :)
    use { 'xiyaowong/nvim-transparent',
        config = function()
            require 'transparent'.setup {
                enable = true,
            }
        end,
--        disable = true
    }

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use { 'TimUntersberger/neogit',
        config = function()
            local neogit = require 'neogit'
            neogit.setup{}
            require 'settings-utils'.keys {
                normal = {
                    ['<leader>gsc'] = neogit.open,
                    ['<leader>gsp'] = function() neogit.open { kind = 'split' } end,
                }
            }
        end
    }

    -- nav
    use {
        'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = vim.fn['fzf#install'],
        },
        config = function()
            local utils = require 'settings-utils'
            utils.keys {
                normal = {
                    ['<leader>ff'] = { cmd = 'Files' },
                    ['<leader>rg'] = { cmd = 'Rg' },
                }
            }
        end
    }

    use {
        'romgrk/barbar.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'settings-utils'.keys {
                normal = {
                    ['<leader>bp'] = { cmd = 'BufferPick' }
                }
            }
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            local utils = require 'settings-utils'
            require 'nvim-tree'.setup {
                disable_netrw = true,
                hijack_netrw = true
            }
            utils.keys {
                normal = {
                    ['<leader>e'] = { cmd = 'NvimTreeToggle' }
                }
            }
        end
    }

    -- lsp
    use 'mfussenegger/nvim-jdtls'
    use { 'neovim/nvim-lspconfig',
    requires = { 'nvim-lua/lsp-status.nvim', 'ms-jpq/coq_nvim' },
    config = function()
        local lsp = require 'lspconfig'
        local util = require 'lspconfig/util'
        local coq = require 'coq'
        local status = require 'lsp-status'
        local utils = require 'settings-utils'
        local options = coq.lsp_ensure_capabilities {
            on_attach = status.on_attach,
            capabilities = status.capabilities,
            settings = {
                rust_analyzer = {
                    checkOnSave = { command = 'clippy' },
                    cargo = { allFeatures = true },
                    checkOnSave = { allFeatures = true, extraArgs = { '--all-features' } },
                }
            }
        }

        lsp.rust_analyzer.setup(options)
        lsp.gopls.setup(options)
        lsp.clangd.setup(options)
        lsp.zls.setup(options)
        lsp.ocamllsp.setup(options)
        lsp.jdtls.setup(options)
        lsp.ghdl_ls.setup(options)

            utils.keys {
            normal = {
                ['<space>,'] = vim.diagnostic.goto_prev,
                ['<space>;'] = vim.diagnostic.goto_next,

                ['<space>a'] = vim.lsp.buf.code_action,
                ['<space>d'] = vim.lsp.buf.definition,
                ['<space>f'] = function() vim.lsp.buf.format { async = true } end,
                ['<space>h'] = vim.lsp.buf.hover,
                ['<space>m'] = vim.lsp.buf.rename,
                ['<space>r'] = vim.lsp.buf.references,
                ['<space>s'] = vim.lsp.buf.document_symbol,
            },
            visual = {
                ['<space>a'] = vim.lsp.buf.range_code_action
            }
        }
    end

}

-- completion
    use {
        'hrsh7th/nvim-cmp',
        requires = { 'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'kdheepak/cmp-latex-symbols',
            'nvim-lua/plenary.nvim'},
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.set_config {
                enable_autosnippets = true,
            }

            -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
            local function has_words_before() 
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,col):match("%s") == nil
            end

            require 'luasnip.loaders.from_lua'.load { paths = "~/.config/nvim/LuaSnip" }
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'latex_symbols' },
                    { name = 'buffer' }
                },
                mapping = cmp.mapping.preset.insert {
                    ["<c-f>"] = cmp.mapping.confirm { select = true },
                    ["<c-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                        elseif has_words_before() then cmp.complete()
                        else fallback()
                        end
                    end, { 'i', 's' }),
                    ["<c-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then luasnip.jump(-1)
                        else fallback()
                        end
                    end, { 'i', 's' })
                }
            }
        end
    }
    use { 'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
        local utils = require 'settings-utils'
        utils.keys {
            normal = {
                ['<leader>ll'] = { cmd = 'TroubleToggle' },
                ['<leader>lw'] = { cmd = 'TroubleWorkspaceToggle' },
                ['<leader>ld'] = { cmd = 'TroubleDocumentToggle' }
            }
        }
        end
      }

      -- mind: take notes to another level
      use {
          'phaazon/mind.nvim',
          branch = 'v2',
          config = function()
              local mind = require 'mind'
              mind.setup()
              require 'settings-utils'.keys {
                normal = { 
                    ['<leader>mm'] = function() mind.open_main() end,
                    ['<leader>mp'] = function() mind.open_project() end,
                }
              }
          end
      }

      -- statusline
      use {
          'nvim-lualine/lualine.nvim',
          requires = {
              { 'kyazdani42/nvim-web-devicons', opt = true }
          },
          config = function()
            require 'lualine'.setup {
                options = { theme = 'catppuccin' },
            }
          end
      }

      -- languages
      use 'ARM9/arm-syntax-vim'
      -- Whoever made this blog, thanks a ton!
      -- https://www.ejmastnak.com/tutorials/vim-latex/intro.html
      use {'lervag/vimtex', 
        config = function() 
            local utils = require 'settings-utils'      
            utils.vars {
                vimtex_view_method = 'zathura',
                vimtex_view_forward_search_on_start = 0
            }
        end
      }
      --use { '~/contrib/jakt/editors/vim', as = 'jakt' }
      use 'fladson/vim-kitty'
      use 'terminalnode/sway-vim-syntax'
  end)

; install & load packer if not present
(let [data-path (vim.fn.stdpath :data)
      install-path (.. data-path :/site/pack/packer/start/packer.nvim)
      expanded-path (vim.fn.glob install-path)]
  (when (not= (vim.fn.empty expanded-path) 0)
    (print "installing packer...")
    (vim.api.nvim_command (.. "!git clone https://github.com/wbthomason/packer.nvim "
                              install-path))
    (vim.api.nvim_command "packadd packer.nvim")))


; this giant macro removes
; the need to use { 1 name }
; when using `use` with a configuration
(macro pkg [name ?config]
  (fn merge-tables [a b]
    (fn is-type [v type-name] (= (type v) type-name))
    (fn both-have-type [a b type-name] (and (is-type a type-name) (is-type b type-name)))
    (var merged {})

    (each [ k v (pairs a) ]
      (tset merged k v))

    (each [ k v (pairs b) ]
      (let [ other-value (. a k) ]
        (tset merged k (if (both-have-type v other-value :table) 
                            (merge-tables v other-value)
                            v))))
    merged)
    
    (assert name "expected a name to the package")
    (if ?config 
      (merge-tables { 1 name } ?config)
      name)
)


; fusion (use) and (pkg)
(macro use-pkg [name ?config]
  `(use (pkg ,name ,?config)))

(local packer (require :packer))

(packer.startup (fn packer-startup [use]
                  (use-pkg :wbthomason/packer.nvim)
                  (use-pkg :arcticicestudio/nord-vim)
                  (use-pkg :phaazon/hop.nvim)
                  (use-pkg :nvim-treesitter/nvim-treesitter)
                  (use-pkg :famiu/feline.nvim { :requires [ :kyazdani42/nvim-web-devicons (pkg :lewis6991/gitsigns.nvim { :requires :nvim-lua/plenary.nvim }) ]
                                                })
                  (use-pkg :kyazdani42/nvim-tree.lua
                           {:requires :kyazdani42/nvim-web-devicons
                            })
                  (use-pkg :jiangmiao/auto-pairs)
                  (use-pkg :tpope/vim-repeat)
                  (use-pkg :tpope/vim-surround)
                  (use-pkg :tpope/vim-repeat)
                  (use-pkg :tpope/vim-fugitive)
                  (use-pkg :b3nj5m1n/kommentary)
                  (use-pkg :junegunn/fzf
                           {:run vim.fn.fzf#install
                            })
                  (use-pkg :junegunn/fzf.vim)
                  (use-pkg :nvim-lua/lsp-status.nvim)
                  (use-pkg :neovim/nvim-lspconfig)
                  (use-pkg :nvim-lua/completion-nvim)
                  (use-pkg :folke/lsp-trouble.nvim
                           {:requires :kyazdani42/nvim-web-devicons
                            })
                  (use-pkg :folke/lsp-colors.nvim)
;                  (use-pkg :lukas-reineke/indent-blankline.nvim) ; plugin is fine but tries to show on top when overscrolling horizontally
;                  (use-pkg :mbbill/undotree)
                  nil))

; after startup
(macro setup-config [name]
  `(require ,(.. :fnl.plug-config. name)))

(macro setup-keys [name]
  `(require ,(.. :fnl.plug-config.keys. name)))

(setup-config :theme)
(setup-config :kommentary)
(setup-config :nvim-lsp)
(setup-config :hop)
(setup-config :treesitter)
(setup-config :gitsigns)
(setup-config :feline)
;(setup-config :indent-blankline)

(setup-keys :fzf)
(setup-keys :lsp)
(setup-keys :vim-fugitive)
(setup-keys :lsp-trouble)
;(setup-keys :hop)
(setup-keys :nvim-tree)

nil

;(import-macros utils :fnl/macros)
(local utils (require :fnl.utils))

(utils.options :global {:hidden true
                        :encoding :utf-8
                        :ruler true
                        :pumheight 10
                        :cmdheight 2
                        :splitbelow true
                        :smarttab true
                        :ignorecase true
                        :wildmode "list:longest"
                        :laststatus 3 ; show only one status bar
                        :showtabline 2
                        :showmode false
                        :backup false
                        :writebackup false
                        :updatetime 300
                        :timeoutlen 500
                        :clipboard :unnamedplus
                        :mouse :nicr
                        :guicursor ""
                        :hlsearch false
                        :ignorecase true
                        :smartcase true
                        :completeopt "menuone,noinsert,noselect"
                        :termguicolors true
                        })

; in order to fix a random nvim + nord bug

(utils.options :window {:wrap false
                        :conceallevel 0
                        :cursorline true
                        :number true
                        :relativenumber true
                        :signcolumn :yes ; always show numbers
                        :list false
                        })

(utils.options :buffer {:tabstop 4
                        :shiftwidth 4
                        :smartindent true
                        :autoindent true
                        :expandtab true
                        :swapfile false ;; disable swapfile
                        })

nil

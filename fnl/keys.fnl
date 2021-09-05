(require-macros :fnl.utils-macros)

; better nav for omnicomplete
(nvim-map :i :<c-j> "\\<c-n>" {:expr true
                          })
(nvim-map :i :<c-j> "\\<c-p>" {:expr true
                          })

; make alt useful
(nvim-map :n :<m-j> :<c-w>j)
(nvim-map :n :<m-k> :<c-w>k)
(nvim-map :n :<m-h> :<c-w>h)
(nvim-map :n :<m-l> :<c-w>l)

; the classic
(nvim-map :i :jk :<esc>)
(nvim-map :v :jk :<esc>)

; tab completion
(nvim-map :i :<tab> "pumvisible() ? \"\\<c-n>\" : \"\\<tab>\""
     {:expr true
      })

; better tabbing
(nvim-map :v "<" :<gv)
(nvim-map :v ">" :>gv)

; :help update
(nvim-mapcmd :n :<leader>w :update)

; quickfix list, from primeagen's video: https://www.youtube.com/watch?v=IoyW8XYGqjM
; global
(nvim-mapcmd :n :<c-j> :cprev)
(nvim-mapcmd :n :<c-k> :cnext)
; local
(nvim-mapcmd :n :<leader>j :lprev)
(nvim-mapcmd :n :<leader>k :lnext)

(nvim-mapcmd :n :<leader>rc "lua require('main')")

nil

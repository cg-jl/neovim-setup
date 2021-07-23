(local map (. (require :fnl.utils) :map))
(local mapcmd (. (require :fnl.utils) :map-command))

; better nav for omnicomplete
(map :i :<c-j> "\\<c-n>" {:expr true
                          })
(map :i :<c-j> "\\<c-p>" {:expr true
                          })

; make alt useful
(map :n :<m-j> :<c-w>j)
(map :n :<m-k> :<c-w>k)
(map :n :<m-h> :<c-w>h)
(map :n :<m-l> :<c-w>l)

; the classic
(map :i :jk :<esc>)
(map :v :jk :<esc>)

; tab completion
(map :i :<tab> "pumvisible() ? \"\\<c-n>\" : \"\\<tab>\""
     {:expr true
      })

; better tabbing
(map :v "<" :<gv)
(map :v ">" :>gv)

; :help update
(mapcmd :n :<leader>w :update)

; quickfix list, from primeagen's video: https://www.youtube.com/watch?v=IoyW8XYGqjM
; global
(mapcmd :n :<c-j> :cprev)
(mapcmd :n :<c-k> :cnext)
; local
(mapcmd :n :<leader>j :lprev)
(mapcmd :n :<leader>k :lnext)

(mapcmd :n :<leader>rc "lua require('main')")

nil

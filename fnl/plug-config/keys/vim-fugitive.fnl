(local mapcmd (. (require :fnl.utils) :map-command))

; git status
(mapcmd :n :<leader>gs :G)
; push
(mapcmd :n :<leader>gp "Git push")

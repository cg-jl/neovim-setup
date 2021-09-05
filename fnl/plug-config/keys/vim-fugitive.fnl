(import-macros utils :fnl.utils-macros)
;(local mapcmd (. (require :fnl.utils) :map-command))

; git status
(utils.nvim-mapcmd :n :<leader>gs :G)
; push
(utils.nvim-mapcmd :n :<leader>gp "Git push")
nil

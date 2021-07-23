(local mapcmd (. (require :fnl.utils) :map-command))

; git status
(mapcmd :n :<leader>gs :G)

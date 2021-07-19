(local mapcmd (. (require :utils) :map-command))

; git status
(mapcmd :n :<leader>gs :G)

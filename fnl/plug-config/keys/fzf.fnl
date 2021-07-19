(local utils (require :utils))

(local mapcmd utils.map-command)

(mapcmd :n :<leader>ff :Files)
(mapcmd :n :<leader>fg :Rg)
(mapcmd :n :<leader>fh :History)
(mapcmd :n :<leader>fc :Commits)
(mapcmd :n :<leader>fb :Buffers)

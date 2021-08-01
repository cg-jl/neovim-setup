(local utils (require :fnl.utils))

(local mapcmd utils.map-command)

(mapcmd :n :<leader>ff :Files)
(mapcmd :n :<leader>rg :Rg)
(mapcmd :n :<leader>fh :History)
(mapcmd :n :<leader>fc :Commits)
(mapcmd :n :<leader>fb :Buffers)

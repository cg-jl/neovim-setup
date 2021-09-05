; (local utils (require :fnl.utils))
(import-macros utils :fnl.utils-macros)


(utils.nvim-mapcmd :n :<leader>ff :Files)
(utils.nvim-mapcmd :n :<leader>rg :Rg)
(utils.nvim-mapcmd :n :<leader>fh :History)
(utils.nvim-mapcmd :n :<leader>fc :Commits)
(utils.nvim-mapcmd :n :<leader>fb :Buffers)
nil

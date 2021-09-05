(import-macros utils :fnl.utils-macros)
;(local utils (require :fnl.utils))

(utils.nvim-mapcmd :n :<leader>ca "Lspsaga code_action")
(utils.nvim-mapcmd :v :<leader>ca "Lspsaga range_code_action")
nil

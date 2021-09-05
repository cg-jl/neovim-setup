(import-macros utils :fnl.utils-macros)
;(local mapcmd (. (require :fnl.utils) :map-command))
(utils.nvim-mapcmd :n :<leader>e :NvimTreeToggle)
(utils.nvim-mapcmd :n :<leader>r :NvimTreeRefresh)
nil

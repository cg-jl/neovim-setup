(import-macros utils :fnl.utils-macros)
;(local utils (require :fnl.utils))
;(local mapcmd utils.map-command)

(utils.nvim-mapcmd :n :<leader>ll :TroubleToggle)
(utils.nvim-mapcmd :n :<leader>lw :TroubleWorkspaceToggle)
(utils.nvim-mapcmd :n :<leader>ld :TroubleDocumentToggle)
nil

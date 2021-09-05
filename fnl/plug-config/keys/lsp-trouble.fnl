(import-macros utils :fnl.utils-macros)
;(local utils (require :fnl.utils))
;(local mapcmd utils.map-command)

(utils.nvim-mapcmd :n :<leader>ll :LspTroubleToggle)
(utils.nvim-mapcmd :n :<leader>lw :LspTroubleWorkspaceToggle)
(utils.nvim-mapcmd :n :<leader>ld :LspTroubleDocumentToggle)
nil

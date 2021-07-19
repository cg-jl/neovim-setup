(local utils (require :utils))
(local mapcmd utils.map-command)

(mapcmd :n :<leader>ll :LspTroubleToggle)
(mapcmd :n :<leader>lw :LspTroubleWorkspaceToggle)
(mapcmd :n :<leader>ld :LspTroubleDocumentToggle)

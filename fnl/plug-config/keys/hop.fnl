(local utils (require :utils))
;; my leader is ',' so these are right and left,
;; respectively
(utils.map-command :n :<leader>. :HopWord)
(utils.map-command :n :<leader>m :HopLine)
(utils.map-command :n :<leader>p :HopPattern)

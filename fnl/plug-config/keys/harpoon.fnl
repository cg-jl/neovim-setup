(local utils (require :fnl.utils))

(utils.map-command :n :<leader>h "lua require('harpoon.mark').add_file()")
(utils.map-command :n :<leader>u
                   "lua require('harpoon.ui').toggle_quick_menu()")

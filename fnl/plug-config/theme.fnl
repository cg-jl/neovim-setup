(local utils (require :utils))

(vim.cmd "colorscheme nord")

(local options {:italic 1
                })

(->> options
     (utils.prefix-options [:nord])
     (utils.set-globals))

nil

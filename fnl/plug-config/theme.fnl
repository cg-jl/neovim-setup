(import-macros mutils :fnl.utils-macros)
(local utils (require :fnl.utils))

(vim.cmd "colorscheme nord")

(local options {:italic 1
                })

(->> (mutils.prefix-options [:nord] { :italic 1 })
     (utils.set-globals))

nil

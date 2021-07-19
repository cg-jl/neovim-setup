(local ts (require :nvim-treesitter.configs))
(ts.setup {:ensure_installed [:c :cpp :rust :fennel]
           :highlight {:enable true
                       }
           })

nil

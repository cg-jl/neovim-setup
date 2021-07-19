(local utils (require :utils))
(fn nvim-tree-options [opts]
  (utils.set-globals (utils.prefix-options [:nvim :tree] opts)))

(nvim-tree-options {:side :left
                    :width 30
                    :ignore [:.git :.node_modules :.cache]
                    :auto_open 1
                    :auto_close 1
                    :quit_on_open 1
                    :follow 1
                    :indent_markers 1
                    :hide_dotfiles 0
                    :git_hl 1
                    :width_allow_resize 1
                    :disable_netrw 1
                    :hijack_netrw 1
                    :add_trailing 1
                    :show_icons {:git 1
                                 :folders 0
                                 :files 0
                                 }
                    :tree_icons {:default " "
                                 :symlink " "
                                 :git {:unstaged "✗ "
                                       :staged "✓ "
                                       :unmerged " "
                                       :renamed "➜ "
                                       :untracked "★ "
                                       }
                                 :folder {:default " "
                                          :open " "
                                          :empty " "
                                          :empty_open " "
                                          :symlink " "
                                          :symlink_open " "
                                          }
                                 }
                    })

nil

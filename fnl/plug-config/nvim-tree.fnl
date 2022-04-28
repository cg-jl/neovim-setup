(local utils (require :fnl.utils))
(local nvim-tree (require :nvim-tree))

(nvim-tree.setup {;:side :left
                    ;:auto_open true
                    ;:auto_close true
                    ;:quit_on_open true
                    ;:follow true
                    ;:indent_markers true
                    ;:hide_dotfiles false
                    ;:git_hl true
                    ;:width_allow_resize true
                    :disable_netrw true
                    :hijack_netrw true
                    ;:add_trailing true
                    ; :show_icons {:git 1
                    ;              :folders 0
                    ;              :files 0
                    ;              }
                    ; :tree_icons {:default " "
                    ;              :symlink " "
                    ;              :git {:unstaged "✗ "
                    ;                    :staged "✓ "
                    ;                    :unmerged " "
                    ;                    :renamed "➜ "
                    ;                    :untracked "★ "
                    ;                    }
                    ;              :folder {:default " "
                    ;                       :open " "
                    ;                       :empty " "
                    ;                       :empty_open " "
                    ;                       :symlink " "
                    ;                       :symlink_open " "
                    ;                       }
                    ;              }
                    })

nil

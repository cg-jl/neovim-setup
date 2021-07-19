(local utils (require :utils))

; add branch NF icon to branch name.
(vim.cmd "
         function! GitHead()
         let head = FugitiveHead()
         if strchars(head) == 0
         return ''
         end
         return ' ' . head
         endfunction")

(utils.set-global :lightline {:colorscheme :nord
                              :active {:left [[:mode :paste]
                                              [:gitbranch
                                               :filename
                                               :modified
                                               :lsp]]
                                       :right [[:lineinfo]
                                               [:filetype]
                                               [:charvaluehex]]
                                       }
                              :component {:charvaluehex "0x%B"
                                          }
                              :component_function {:gitbranch :GitHead
                                                   :lsp :LspStatus
                                                   }
                              :separator {:left ""
                                          :right ""
                                          }
                              :subseparator {:left ""
                                             :right ""
                                             }
                              })

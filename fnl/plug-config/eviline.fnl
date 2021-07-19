(local gl (require :galaxyline))
(local condition (require :galaxyline.condition))
(local gls (. gl :section))

; gruvbox!
(local colors {:bg "#282828"
               :fg "#ebdbb2"
               :yellow "#fabd2f"
               :cyan "#8ec07c"
               :darkblue "#458588"
               :green "#b8bb26"
               :orange "#fe8019"
               :violet "#b16286"
               :magenta "#d3869b"
               :blue "#83a598"
               :red "#fb4934"
               })

(fn add-section [name value]
  (table.insert (. gls name) value))

(tset gl :short_line_list [:NvimTree :packer])

(add-section :left {:RainbowRed {:provider (fn []
                                             "▊ ")
                                 :highight [colors.darkblue colors.bg]
                                 }
                    })

(add-section :left {:ViMode {:provider (fn [] ; auto change color according the vim mode
                                         (let [mode-color {:n colors.red
                                                           :i colors.green
                                                           :v colors.blue
                                                           "\022" colors.blue
                                                           :V colors.blue
                                                           :c colors.magenta
                                                           :no colors.red
                                                           :s colors.orange
                                                           :S colors.orange
                                                           "\019" colors.orange
                                                           :ic colors.yellow
                                                           :R colors.violet
                                                           :Rv colors.violet
                                                           :cv colors.red
                                                           :ce colors.red
                                                           :r colors.cyan
                                                           :rm colors.cyan
                                                           :r? colors.cyan
                                                           :! colors.red
                                                           :t colors.red
                                                           }]
                                           (vim.api.nvim_command (.. "hi GalaxyViMode guifg="
                                                                     (. mode-color
                                                                        (vim.fn.mode))))
                                           "  "))
                             :highlight [colors.red colors.bg :bold]
                             }
                    })

(add-section :left {:FileSize {:provider :FileSize
                               :condition condition.buffer_not_empty
                               :highlight [colors.fg colors.bg]
                               }
                    })

(add-section :left {:FileIcon {:provider :FileIcon
                               :condition condition.buffer_not_empty
                               :highlight [(. (require :galaxyline.provider_fileinfo)
                                              :get_file_icon_color)
                                           colors.bg]
                               }
                    })

(add-section :left {:FileName {:provider :FileName
                               :condition condition.buffer_not_empty
                               :highlights [colors.magenta colors.bg :bold]
                               }
                    })

(add-section :left {:LineInfo {:provider :LineColumn
                               :separator " "
                               :separator_highlight [:NONE colors.bg]
                               :highlight [colors.fg colors.bg]
                               }
                    })

(add-section :left {:PerCent {:provider :LinePercent
                              :separator " "
                              :separator_highlight [:NONE colors.bg]
                              :highlight [colors.fg colors.bg :bold]
                              }
                    })

(add-section :left {:DiagnosticError {:provider :DiagnosticError
                                      :icon "  "
                                      :highlight [colors.red colors.bg]
                                      }
                    })

(add-section :left {:DiagnosticWarn {:provider :DiagnosticWarn
                                     :icon "  "
                                     :highlight [colors.yellow colors.bg]
                                     }
                    })

(add-section :left {:DiagnosticHint {:provider :DiagnosticHint
                                     :icon "  "
                                     :highlight [colors.cyan colors.bg]
                                     }
                    })

(add-section :left {:DiagnosticInfo {:provider :DiagnosticInfo
                                     :icon "  "
                                     :highlight [colors.blue colors.bg]
                                     }
                    })

(add-section :mid {:ShowLspClient {:provider :GetLspClient
                                   :condition (fn []
                                                (let [tbl {:dashboard true
                                                           "" true
                                                           }]
                                                  (= (. tbl vim.bo.filetype)
                                                     nil)))
                                   :icon " LSP:"
                                   :highlight [colors.cyan colors.bg :bold]
                                   }
                   })

(add-section :right {:FileEncode {:provider :FileEncode
                                  :condition condition.hide_in_width
                                  :separator " "
                                  :separator_highlight {:NONE colors.bg
                                                        }
                                  :highlight [colors.green colors.bg :bold]
                                  }
                     })

(add-section :right {:FileFormat {:provider :FileFormat
                                  :condition condition.hide_in_width
                                  :separator " "
                                  :separator_highlight [:NONE colors.bg]
                                  :highlight [colors.green colors.bg :bold]
                                  }
                     })

(add-section :right {:GitIcon {:provider (fn []
                                           "  ")
                               :condition condition.check_git_workspace
                               :separator " "
                               :separator_highlight [:NONE colors.bg]
                               :highlight [colors.violet colors.bg :bold]
                               }
                     })

(add-section :right {:GitBranch {:provider :GitBranch
                                 :condition condition.check_git_workspace
                                 :highlight [colors.violet colors.bg :bold]
                                 }
                     })

(add-section :right {:DiffAdd {:provider :DiffAdd
                               :condition condition.hide_in_width
                               :icon "  "
                               :highlight [colors.green colors.bg]
                               }
                     })

(add-section :right {:DiffModified {:provider :DiffModified
                                    :condition condition.hide_in_width
                                    :icon " 柳"
                                    :highlight [colors.orange colors.bg]
                                    }
                     })

(add-section :right {:DiffRemove {:provider :DiffRemove
                                  :condition condition.hide_in_width
                                  :icon "  "
                                  :highlight [colors.red colors.bg]
                                  }
                     })

(add-section :right {:RainbowBlue {:provider (fn []
                                               " ▊")
                                   :highlight [colors.blue colors.bg]
                                   }
                     })

(add-section :short_line_left {:BufferType {:provider :FileTypeName
                                            :separator " "
                                            :separator_highlight [:NONE
                                                                  colors.bg]
                                            :highlight [colors.blue
                                                        colors.bg
                                                        :bold]
                                            }
                               })

(add-section :short_line_left {:SFileName {:provider :SFileName
                                           :condition condition.buffer_not_empty
                                           :highlight [colors.fg
                                                       colors.bg
                                                       :bold]
                                           }
                               })

(add-section :short_line_right {:BufferIcon {:provider :BufferIcon
                                             :highlight [colors.fg colors.bg]
                                             }
                                })

(vim.api.nvim_command "hi! StatusLine guifg=#282828")
nil

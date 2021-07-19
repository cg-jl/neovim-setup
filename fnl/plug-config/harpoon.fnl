(local harpoon (require :harpoon))

(harpoon.setup {:global_settings {:save_on_toggle false
                                  :save_on_change true
                                  }
                :projects {:$HOME/qwacc {:term {:cmds ["cargo test"
                                                       "cargo run"]
                                                }
                                         :mark {:marks []
                                                }
                                         }
                           }
                })

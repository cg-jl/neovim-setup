(local kommentary-config (require :kommentary.config))

(kommentary-config.use_extended_mappings)

(kommentary-config.configure_language :default
                                      {:prefer_single_line_comments true
                                       })

(kommentary-config.configure_language :rust
                                      {:single_line_comment_string "//"
                                       :multi_line_comment_strings ["/*" "*/"]
                                       })

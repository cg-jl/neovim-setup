(local nvim-lsp (require :lspconfig))
(local lsp-status (require :lsp-status))
(local utils (require :fnl.utils))
(local completion (require :completion))
(local lsp-util (require :lspconfig/util))

(fn on-attach [client]
  (doto client
    (completion.on_attach)
    (lsp-status.on_attach))
  nil)

(lsp-status.config {:current_function true
                    })

(lsp-status.register_progress)

; register progress handler

; for lightline


(local default-options {:on_attach on-attach
                        :capabilities (->> (vim.lsp.protocol.make_client_capabilities) (utils.merge-tables lsp-status.capabilities))
                        })

; don't ask.
(macro setup-lsp [name options-override?]
  (local options (if options-override?
                     `(utils.merge-tables default-options ,options-override?)
                     `default-options))
  `((. nvim-lsp ,name :setup) ,options))

;; use clippy
(setup-lsp :rust_analyzer {:settings {:rust-analyzer {:checkOnSave {:command :clippy
                                                                    }
                                                      }
                                      }
                           })

(setup-lsp :hls)
(setup-lsp :gopls)
(setup-lsp :clangd {:settings {
                               }
                    })

;(nvim-lsp.rust_analyzer.setup default-options)

; rust
; (nvim-lsp.rust_analyzer.setup default-options)
; c/cpp
; (nvim-lsp.ccls.setup default-options)
; python
;(nvim-lsp.pyls.setup default-options)
; scala
;(nvim-lsp.metals.setup default-options)
; haskell needs hls: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#hls
;(nvim-lsp.hls.setup default-options)
;(nvim-lsp.gopls.setup default-opt)

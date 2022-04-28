(local feline (require :feline))
(local vi-mode-utils (require :feline.providers.vi_mode))
(local feline-lsp (require :feline.providers.lsp))
(local utils (require :fnl.utils))
(import-macros mutils :fnl.utils-macros)

; (local default-bg :#434c5e)
; (local dark-bg-1 :#3b4252)
; (local dark-bg-2 :#2e3440)
(macro  default-bg [] :#504945) ; bg2
(macro dark-bg-1 []  :#3c3836)
(macro dark-bg-2 []  :#1d2021)



; https://bitbucket.org/luizcoro/dotfiles/src/master/.config/nvim/lua/statusbar.lua


(fn vi-mode-provider []
 (local mode-alias {
   :n :NORMAL
   :no :NORMAL
   :i :INSERT
   :v :VISUAL
   :V :V-LINE
   "" :V-BLOCK
   :c :COMMAND
   :cv :COMMAND
   :ce :COMMAND
   :R :REPLACE
   :Rv :REPLACE
   :s :SELECT
   :S :SELECT
   "" :SELECT
   :t :TERMINAL
  })
 (.. " " (. mode-alias (vim.fn.mode))))



; " "

(local components {
  :active [ [] [] [] ]
})

(macro lsp-card [typ ?is-first]
  (assert typ "Need a type (errors, warnings, hints, info)")
  (let [ fn-arg (match typ :errors :error :warnings :warn :hints :hint :info :info _ nil)
         color (match typ :errors :red :warnings :yellow :hints :white :info :green) ]
       (assert fn-arg "Bad type")
       (assert color "Bad type")
       `{
          :provider ,(.. :diagnostic_ typ)
          :enabled #(feline-lsp.diagnostics_exist ,fn-arg)
          :hl { :fg ,color :bg (dark-bg-2) }
          :left_sep { :str :slant_left :hl { :fg (dark-bg-2) :bg ,(if ?is-first `(dark-bg-1) `(dark-bg-2)) } }
         }))

(local lsp-status (require :lsp-status))


(-> components (. :active) (doto
    (-> (. 1) (doto
        (table.insert { :provider :vi_mode :hl #{ :name (vi-mode-utils.get_mode_highlight_name) :style :bold :fg (vi-mode-utils.get_mode_color) } 
                        :right_sep "  " :left_sep " "})
        (table.insert { :provider :file_info
                        :hl { :fg :#ebdbb2 :bg (dark-bg-1) :style :bold }
                        :left_sep [ { :str :slant_left :hl { :fg (dark-bg-1) } } { :str " " :hl { :bg (dark-bg-1) } } ]})
        (table.insert { :provider :position
                        :left_sep [ { :str :slant_left_thin :hl { :bg (dark-bg-1) } } { :str " " :hl { :bg ( dark-bg-1 ) } } ]
                        :right_sep [ { :str " " :hl { :bg ( dark-bg-1 ) } } { :str :slant_right_2 :hl { :bg ( dark-bg-2 ) :fg ( dark-bg-1 ) } } ]
                        :hl { :fg :white :bg ( dark-bg-1 ) }
                        :enabled (fn [] (> (vim.fn.getfsize (vim.fn.expand :%:p)) 0))})
        ; lsp

        (table.insert (lsp-card :info true))
        (table.insert (lsp-card :hints))
        (table.insert (lsp-card :warnings))
        (table.insert (lsp-card :errors))

    ))
    (-> (. 3) (doto
        (table.insert { :provider #(->> (lsp-status.status) (utils.shorten 85)) :hl { :bg ( dark-bg-2 ) :fg :white  } 
                        :enabled #(-> (vim.lsp.buf_get_clients) (length) (> 0))
                        })
        (table.insert { :provider :git_branch :hl { :fg :white :bg ( dark-bg-1 ) } 
;                        :enabled #(-> vim.b.gitsigns_status_dict (not= nil))
                        :right_sep #{ :str " " :hl  {  :bg ( dark-bg-1 ) :fg :NONE} } 
                        :left_sep [ { :str :slant_left_2 :hl { :bg ( dark-bg-2 ) :fg ( dark-bg-1 ) } } ]
                        })
        (table.insert { :provider :git_diff_added :hl { :fg :green :bg ( dark-bg-1 ) }
                        :right_sep { :str " " :hl { :bg ( dark-bg-1 ) } }
                        })
        (table.insert { :provider :git_diff_changed :hl { :fg :orange :bg ( dark-bg-1 ) }
                        :right_sep { :str " " :hl { :bg ( dark-bg-1 ) } }})
        (table.insert { :provider :git_diff_removed :hl { :fg :red :bg ( dark-bg-1 ) }
                        :right_sep [ #{ :str (if vim.b.gitsigns_status_dict " " "") :hl { :bg ( dark-bg-1 ) } } { :str :slant_right_2 :hl { :fg ( dark-bg-1 ) } } ]})
        (table.insert { :provider :line_percentage :hl { :style :bold }
                        :right_sep " "
                        :left_sep " "
                        })
;        (table.insert { :provider lsp-status.status :enabled #(-> (vim.lsp.buf_get_clients) (length) (> 0)) :hl { :bg dark-bg-1 :fg :white } })

    ))


))

; monokai theme uses same gruvbox colors.
(macro gruvbox-colors [] 
{
  :black :#282828
  :skyblue :#83a598
  :cyan :#8ec07c
  :green :#b8bb26
  :oceanblue :#458588
  :magenta :#d3869b
  :orange :#fe8019
  :red :#fb4934
  :violet :#b16286
  :white :#ebdbb2 ; maybe I should use fg0 (#fbf1c7)
  :yellow :#fabd2f
  :fg     :#fabd2f
  :bg     `(default-bg)
 }
 )




(feline.setup {
    :colors (mutils.theme-toggle {
      :nord {
        :black :#434c5e
        :skyblue :#81a1c1
        :cyan :#88c0d0
        :green :#8fbcbb
        :oceanblue :#5e81ac
        :magenta :#b48ead
        :orange :#d08770
        :red :#ec5f67
        :violet :#b48ead
        :white :#eceff4
        :yellow :#ebcb8b
        :fg     :#8fbcbb
        :bg      (default-bg)
  }
  :gruvbox (gruvbox-colors)
  :monokai (gruvbox-colors)
  :rose-pine {
        :black :#21202e
        :skyblue :#9ccfd8
        :cyan :#8ec07c
        :green :#9ccfd8
        :oceanblue :#458588
        :magenta :#d3869b
        :orange :#fe8019
        :red :#eb6f92 ; love
        :violet :#c4a7e7 ; iris
        :white :#e0def4 ; maybe I should use fg0 (#fbf1c7)
        :yellow :#fabd2f
        :fg     :#e0def4
        :bg     (default-bg)
      }
  })
    :vi_mode_colors {
; nord
;   :NORMAL :skyblue
  :NORMAL (mutils.theme-toggle { :gruvbox :#bcae93; gruvbox (fg4)
                                 :monokai :#bcae93
                                 :nord :skyblue
                                 :rose-pine :skyblue })
  :OP :cyan
  :INSERT (mutils.theme-toggle { :nord :#fb1c7 :rose-pine :#9ccfd8  }) ; gruvbox (fg0)
  :VISUAL :green
  :BLOCK :green
  :REPLACE :yellow
  :V-REPLACE :yellow
  :ENTER :cyan
  :MORE :cyan
  :SELECT :magenta
  :COMMAND :cyan
  :SHELL :skyblue
  :TERM :skyblue
  :NONE :orange
      }
    : components
   })

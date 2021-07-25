(local feline (require :feline))
(local vi-mode-utils (require :feline.providers.vi_mode))
(local feline-lsp (require :feline.providers.lsp))
(local utils (require :fnl.utils))

(local default-bg :#434c5e)
(local dark-bg-1 :#3b4252)
(local dark-bg-2 :#2e3440)



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
  :left { :active {} :inactive [] }
  :right { :active [] :inactive [] }
  :mid { :active [] :inactive [] }
 })

(macro lsp-card [typ ?is-first]
  (assert typ "Need a type (errors, warnings, hints, info)")
  (let [ fn-arg (match typ :errors :Error :warnings :Warning :hints :Hint :info :Information _ nil)
         color (match typ :errors :red :warnings :yellow :hints :skyblue :info :green) ]
       (assert fn-arg "Bad type")
       (assert color "Bad type")
       `{
          :provider ,(.. :diagnostic_ typ)
          :enabled #(feline-lsp.diagnostics_exist ,fn-arg)
          :hl { :fg ,color :bg dark-bg-2 }
          :left_sep { :str :slant_left :hl { :fg dark-bg-2 :bg ,(if ?is-first `dark-bg-1 `dark-bg-2) } }
         }))

(local lsp-status (require :lsp-status))


(doto components
  (-> (. :left :active)
      (doto
        (table.insert { :provider :vi_mode :hl (fn vi-mode-hl [] {
          :name (vi-mode-utils.get_mode_highlight_name)
          :style :bold
          :fg (vi-mode-utils.get_mode_color)
          
                                   }) :right_sep " " :left_sep " " })
        (table.insert { :provider :file_info
                        :hl { :fg :skyblue :bg dark-bg-1 :style :bold }
                        :left_sep [ { :str :slant_left :hl { :fg dark-bg-1 } } { :str " " :hl { :bg dark-bg-1 } } ]})
        (table.insert { :provider :position
                        :left_sep [ { :str :slant_left_thin :hl { :bg dark-bg-1 } } { :str " " :hl { :bg dark-bg-1 } } ]
                        :right_sep [ { :str " " :hl { :bg dark-bg-1 } } { :str :slant_right_2 :hl { :bg dark-bg-2 :fg dark-bg-1 } } ]
                        :hl { :fg :skyblue :bg dark-bg-1 }
                        :enabled (fn [] (> (vim.fn.getfsize (vim.fn.expand :%:p)) 0))})
        ; lsp

        (table.insert (lsp-card :info true))
        (table.insert (lsp-card :hints))
        (table.insert (lsp-card :warnings))
        (table.insert (lsp-card :errors))

        )
  )
  (-> (. :right :active)
      (doto
        ; TODO: get diagnostics to show
        (table.insert { :provider #(->> (lsp-status.status) (utils.shorten 85)) :hl { :bg dark-bg-2 :fg :skyblue  } 
                        :enabled #(-> (vim.lsp.buf_get_clients) (length) (> 0))
                        })
        (table.insert { :provider :git_branch :hl { :fg :white :bg dark-bg-1 } 
;                        :enabled #(-> vim.b.gitsigns_status_dict (not= nil))
                        :right_sep #{ :str " " :hl  {  :bg dark-bg-1 :fg :NONE} } 
                        :left_sep [ { :str :slant_left_2 :hl { :bg dark-bg-2 :fg dark-bg-1 } } ]
                        })
        (table.insert { :provider :git_diff_added :hl { :fg :green :bg dark-bg-1 }
                        :right_sep { :str " " :hl { :bg dark-bg-1 } }
                        })
        (table.insert { :provider :git_diff_changed :hl { :fg :orange :bg dark-bg-1 }
                        :right_sep { :str " " :hl { :bg dark-bg-1 } }})
        (table.insert { :provider :git_diff_removed :hl { :fg :red :bg dark-bg-1 }
                        :right_sep [ #{ :str (if vim.b.gitsigns_status_dict " " "") :hl { :bg dark-bg-1 } } { :str :slant_right_2 :hl { :fg dark-bg-1 } } ]})
        (table.insert { :provider :line_percentage :hl { :style :bold }
                        :right_sep " "
                        :left_sep " "
                        })
;        (table.insert { :provider lsp-status.status :enabled #(-> (vim.lsp.buf_get_clients) (length) (> 0)) :hl { :bg dark-bg-1 :fg :white } })
      )
  )
)

; (fn vi-mode-hl []
;   (local vi-mode (require :feline.providers.vi_mode))
;   { :name (vi-mode.get_mode_highlight_name)
;     :fg :bg
;     :bg (vi-mode.get_mode_color)
;     :style :bold})

(local colors {
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
 })

(local vi_mode_colors {
  :NORMAL :skyblue
  :OP :cyan
  :INSERT :white
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
 })




  (->> {
    :default_fg :#8fbcbb
    :default_bg default-bg
    : colors
    : vi_mode_colors
    : components

   }
    (feline.setup))

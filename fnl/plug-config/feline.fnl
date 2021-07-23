(local feline (require :feline))
(local feline-preset (require :feline.presets.default))

(local default-bg :#2e3440)

(fn see [tbl]
  (each [ k v (pairs tbl) ]
    (print k v)))

(macro thin-right-arrow [fg bg]  `{ :str "" :hl { :bg ,bg :fg ,fg } } )
(macro thicc-right-arrow [fg bg]  `{ :str "" :hl { :bg ,bg :fg ,fg } } )

(doto feline-preset.components
  ; fix spacing (no slants)
  (tset :left :active 3 :right_sep [ (thicc-right-arrow :oceanblue default-fg) " " ])
  (tset :left :active 3 :left_sep [ " " (thicc-right-arrow default-bg :oceanblue ) { :str " " :hl { :bg :oceanblue :fg :NONE } } ])
  (tset :left :active 4 :right_sep  [ " " (thin-right-arrow :cyan default-bg) ])
  (tset :left :active 5 :right_sep  (thin-right-arrow :cyan default-bg))
  (tset :left :active 5 :left_sep "")
  (tset :right :active 1 :left_sep { :str "" :hl { :bg default-bg :fg :black } })
  (tset :right :active 4 :right_sep [ { :str " " :hl { :fg :NONE :bg :black } } { :str "" :hl { :bg :black :fg default-bg } } ])
  )



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
  :NORMAL :cyan
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

   }
    (feline.setup))

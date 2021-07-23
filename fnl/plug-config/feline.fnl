(local feline (require :feline))

(feline.setup)

; https://bitbucket.org/luizcoro/dotfiles/src/master/.config/nvim/lua/statusbar.lua
(fn get-diagnostic [str]
  (let [ count (vim.lsp.diagnostic.get_count 0 str) ]
    (or (and (> count 0) (.. " " count " ")) "")))


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
 (.. " " (. mode-alias (vim.fn.mode)) " "))

(fn percentage-provider []
  (local cursor (require :feline.providers.cursor))
  (.. " " (cursor.line_percentage) " "))


(fn vi-mode-hl []
  (local vi-mode (require :feline.providers.vi_mode))
  { :name (vi-mode.get_mode_highlight_name)
    :fg :bg
    :bg (vi-mode.get_mode_color)
    :style :bold})

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

(var components {})

(doto components
  (tset :left {})
  (tset :right {})
  (tset :mid {}))

(doto components.left
  (tset :active {}))


  (->> {
    :default_fg :#8fbcbb
    :default_bg :#2e3440
    : colors
    : vi_mode_colors
    : components

   }
    (feline.setup))

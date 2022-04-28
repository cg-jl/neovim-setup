; https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#customize-buffers-display-to-look-like-leaderf
(local devicons (require :nvim-web-devicons))
(local filter vim.tbl_filter)
(local map vim.tbl_map)
(local entry-display (require :telescope.pickers.entry_display))

(fn gen-from-buffer [opts]
  (let [ opts (or opts {})
         (default-icons _) (devicons.get_icon :file "" { :default true })
         bufnrs (->> (vim.api.nvim_list_bufs) (filter #(= 1 (vim.fn.buflisted $1))))
         max-bufnr (math.max (unpack bufnrs))
         bufnr-width (-> bufnr tostring length)
         max-bufname (->> bufnrs (map #(-> $1 (vim.api.nvim_buf_get_name) (vim.fn.fnamemodify ::p:t) (vim.fn.strdisplaywidth))) unpack)
         displayer (entry-display.create {
           :separator " "
           :items [
             { :width bufnr-width }
             { :width 4 }
             { :width (vim.fn.strwidth default-icons) }
             { :width max-bufname  }
             { :remaining true }
           ]})
         ] 
    (fn make-display [entry] (displayer [
      [entry.bufnr :TelescopeResultsNumber]
      [entry.indicator :TelescopeResultsComment]
      [entry.devicons entry.devicons_highlight]
      entry.file_name
      [entry.dir_name :Comment]
    ]))
    (fn [entry]
      (print (vim.inspect entry))
      (let [ bufname (if (not= entry.info.name "") entry.info.name "[No Name]")
             hidden (if (= entry.info.hidden 1) :h :a)
             readonly (if (vim.api.nvim_buf_get_option entry.bufnr :readonly) := " ")
             changed (if (= entry.info.changed 1) "+" " ")
             indicator (.. entry.flag hidden readonly changed)
             dir-name (vim.fn.fnamemodify bufname :p:h)
             file-name (vim.fn.fnamemodify bufname :p:t)
             (icons highlight) (devicons.get_icon bufname (string.match bufname "%a+$") { :default true})
            ] 
      {
        :valid true
        :value bufname
        :ordinal (.. entry.bufnr " : " file-name)
        :display make-display
        :bufnr entry.bufnr
        :lnum (if (not= entry.info.lnum 0) entry.info.lnum 1)
        : indicator
        :devicons icons
        :devicons_highlight highlight
        :file_name file-name
        :dir_name dir-name
      })
    ))
)


(let [ tp (require :telescope)
       theme { :theme :dropdown} ]
  (tp.setup {
    :pickers {
      :find_files theme
      :buffers theme
      :live_grep theme
      :git_files theme
    }
  })
  (tp.load_extension :git_worktree)
  (tp.load_extension :fzy_native))

gen-from-buffer
; (local tp (require :telescope))
; (local actions (require :telescope.actions))
; (local previewers (require :telescope.previewers))
;
; ; (tp.setup { :defaults { :mappings { :i { "<esc>" actions.close } }}})
; nil

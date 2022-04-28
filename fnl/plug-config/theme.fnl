(import-macros mutils :fnl.utils-macros)
(local utils (require :fnl.utils))

(->>  (mutils.theme-toggle {
      :monokai (mutils.prefix-options [:sonokai] { :style :espresso })
      :gruvbox (mutils.prefix-options [:gruvbox] { :italic 1 })
      :nord    (mutils.prefix-options [:nord]    { :italic 1 })
      :rose-pine {}
      })
      (utils.set-globals)
)

;(vim.cmd "colorscheme sonokai")

(vim.cmd (mutils.theme-toggle {
  :monokai "colorscheme sonokai"
  :gruvbox "colorscheme gruvbox"
  :nord    "colorscheme nord"
  :rose-pine "colorscheme rose-pine"
}))

(vim.cmd "hi! Normal ctermbg=NONE guibg=NONE") ; set background to be terminals'
(vim.cmd "hi! EndOfBuffer ctermbg=NONE guibg=NONE") ; set background to be terminals'

nil

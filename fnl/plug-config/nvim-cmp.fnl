
((. (require :cmp_nvim_lsp) :setup))

(local cmp (require :cmp))



; https://github.com/timbedard/dotfiles/blob/main/config/nvim/lua/plugins.lua#L301
  (cmp.setup {
    :min_length 0
    :mapping {
      :<c-n>      (cmp.mapping.select_next_item)
      :<c-space>  (cmp.mapping.complete)
      :<c-e>      (cmp.mapping.close)
      :<c-p>      (cmp.mapping.select_prev_item)
      :<tab>      (cmp.mapping.select_next_item)
      :<s-tab>    (cmp.mapping.select_prev_item)
    }
    :sources { :name :nvim_lsp }
   })

nil

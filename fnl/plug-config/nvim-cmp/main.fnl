
((. (require :cmp_nvim_lsp) :setup))

(local cmp (require :cmp))
(local lspkind (require :lspkind))



; from <https://github.com/timbedard/dotfiles/blob/main/config/nvim/lua/plugins.lua#L301>
  (cmp.setup {
    :min_length 0
    :mapping {
      :<c-n>      (cmp.mapping.select_next_item)
      :<c-f>      (cmp.mapping.complete)
      :<c-e>      (cmp.mapping.close)
      :<c-p>      (cmp.mapping.select_prev_item)
    }
    :snippet {
      :expand (fn [args] (vim.fn.vsnip#anonymous args.body))
    }
    :sources (cmp.config.sources [ { :name :gh_source } { :name :nvim_lsp } ])
    :experimental {
        :ghost_text true
    }
    :view { :entries :native }
    :formatting {
        :format (lspkind.cmp_format {
            :with_text false  ; do not show text alongside icons
            :maxwidth  50    ; prevent the popup from showing more than provided characters
        })
      }
   })

((. (require :colorbuddy) :setup))

; Clone of TJDevrie's TakeTuesday E01
; (let [ colorbuddy-group (require :colorbuddy.group)
;        Group colorbuddy-group.Group
;        g colorbuddy-group.groups
;        s colorbuddy-group.styles
;     ]
;   (Group.new :CmpItemAbbr g.Comment)
;   (Group.new :CmpItemAbbrDeprecated g.Error)
;   (Group.new :CmpItemAbbrMatchFuzzy (: g.CmpItemAbbr.fg :dark) nil s.italic)
;   (Group.new :CmpItemKind g.Special)
;   (Group.new :CmpItemMenu g.NonText)
; )

nil

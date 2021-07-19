(local utils (require :utils))

; context_patterns = {
;        "declaration", "expression", "pattern", "primary_expression",
;        "statement", "switch_body"
;}

(->> {:use_treesitter true
      :show_current_context true
      :context_patterns [:declaration
                        :expression
                        :pattern
                        :primary_expression
                        :statement
                        :switch_body]
      }
     (utils.prefix-options [:indent :blankline])
     (utils.set-globals))

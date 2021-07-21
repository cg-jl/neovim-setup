(local utils (require :utils))

(->> {:use_treesitter true
      :show_current_context true
      :context_patterns [:declaration
                        :expression
                        :pattern
                        :class
                        :method
                        :function
                        :primary_expression
                        :statement
                        :switch_body]
      :char "│"
      }
     (utils.prefix-options [:indent :blankline])
     (utils.set-globals))

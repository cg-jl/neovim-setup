local utils = require("utils")
return utils["set-globals"](
  utils["prefix-options"]({"indent", "blankline"}, 
                          {char = "\226\148\130", context_patterns = {"declaration", "expression", "pattern", "primary_expression", "statement", "switch_body"}, show_current_context = true, use_treesitter = true}))

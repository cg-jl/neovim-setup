(import-macros utils :fnl.utils-macros)

(utils.nvim-mapcmd :n :<leader>bt "lua require('dap').toggle_breakpoint()")
(utils.nvim-mapcmd :n :<leader>bc "lua require('dap').continue()")
(utils.nvim-mapcmd :n :<leader>so "lua require('dap').step_over()")
(utils.nvim-mapcmd :n :<leader>si "lua require('dap').step_into()")
(utils.nvim-mapcmd :n :<leader>repl "lua require('dap').repl.open()")


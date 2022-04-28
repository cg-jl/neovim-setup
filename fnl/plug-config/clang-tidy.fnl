(import-macros mutils :fnl.utils-macros)


(let [clang-tidy (require :clang-tidy)] (clang-tidy.setup {}))

(mutils.nvim-mapcmd :n "<leader>a" "lua require('clang-tidy').run()")


nil


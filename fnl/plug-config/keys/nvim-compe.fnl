(local utils (require :fnl.utils))

(utils.map :i :<c-space> "compe#complete()")
(utils.map :i :<cr>      "compe#confirm(luaeval(\"require 'nvim-autopairs'.autpairs_cr()\"))")
(utils.map :i :<c-e>     "compe#close('<c-e>')")
(utils.map :i :<c-f>     "compe#scroll({ 'delta' : +4 })")
(utils.map :i :<c-d>     "compe#scroll({ 'delta' : -4 })")

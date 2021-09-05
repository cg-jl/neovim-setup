  (fn merge-tables [a b]
  (fn is-type [v type-name]
    (= (type v) type-name))

  (fn both-have-type [a b type-name]
    (and (is-type a type-name) (is-type b type-name)))

  (var merged {})

  (each [k v (pairs a)]
    (tset merged k v))
  (each [k v (pairs b)]
    (let [other-value (. a k)]
      (tset merged k (if (both-have-type v other-value :table)
                         (merge-tables v other-value)
                         v))))
  merged)


(fn nvim-map [mode lhs rhs ?more-options]
  (let [ options { :noremap true :silent true }
         real-options (if ?more-options (merge-tables options ?more-options) options)]
    `(vim.api.nvim_set_keymap ,mode ,lhs ,rhs ,real-options)
  ))

(fn nvim-mapcmd [mode lhs cmd ?more-options]
  (let [ cmd (.. "<cmd>" cmd :<cr>) ] (nvim-map mode lhs cmd ?more-options)))


; gets a list of prefixes, e.g [ :nvim :tree ] and a table of
; options such as { :a 1 :b 2 } then it returns { :nvim_tree_a 1 :nvim_tree_b 2 }
(fn prefix-options [prefixes kvpairs]
  (var tbl {})
  (local built-prefix (-> prefixes
                          (table.concat "_")
                          (.. "_")))
  (each [k v (pairs kvpairs)]
    (tset tbl (.. built-prefix k) v))
  tbl)

{ : nvim-map
  : nvim-mapcmd
  : merge-tables
  : prefix-options }

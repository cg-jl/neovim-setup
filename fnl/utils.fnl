(fn map [mode lhs rhs more-options?]
  (var options {:noremap true
                :silent true
                })
  (if more-options?
      (set options (vim.tbl_extend :force options more-options?)))
  (vim.api.nvim_set_keymap mode lhs rhs options))

(fn is-in-table [tbl value]
  (each [_ v (ipairs tbl)]
    (when (= v value)
      (lua "return true")))
  false)

(fn options [scope kvpairs]
  (let [scope-index (match scope
                      :global :o
                      :buffer :bo
                      :window :wo)
        tset-fn (if (not= scope :global)
                    (fn [k v]
                      (tset vim scope-index k v)
                      (tset vim.o k v))
                    (fn [k v]
                      (tset vim scope-index k v)))]
    (each [k v (pairs kvpairs)]
      (tset-fn k v))))

(fn count-true [tbl filter]
  (var count 0)
  (each [ _ v (ipairs tbl) ]
    (when (filter v) (set count (+ count 1))))
  count)

(fn reverse-inplace [tbl]
  (for [ k 1 (length tbl) ]
    (lua "tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]")))

(fn shorten [maxlen str]
  (if (> (length str) maxlen)
    (.. (string.sub str 1 (- maxlen 3)) "...")
    str))

; (fn options [scope kvpairs]
;   (print "scope:" scope)
;   (let [api-option-infix (match scope
;                            :global ""
;                            :buffer :_buf
;                            :window :_win)
;         api-call (. vim :api (.. :nvim api-option-infix :_set_option))]
;     (each [k v (pairs kvpairs)]
;       (api-call k v))))

; gets a name (string) and
; converts it to a command string,
; e.g 'echo hello' -> ':echo hello<cr>'
(fn make-command [name]
  (.. ":" name :<cr>))

(fn map-command [mode lhs rhs more-options?]
  (map mode lhs (make-command rhs) more-options?))

(fn set-global [key value]
  (tset vim.g key value))

(fn set-globals [kvpairs]
  (each [k v (pairs kvpairs)]
    (tset vim.g k v)))

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

; gets environment variables
(fn env []
  (var variables {})
  (each [k v (pairs (vim.fn.environ))]
    (table.insert variables (string.format "%s=%s" k v)))
  variables)

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

; Exports

{: is-in-table
 : options
 : map
 : map-command
 : set-global
 : set-globals
 : merge-tables
 : make-command
 : prefix-options
 : count-true
 : shorten
 :imap (partial map :i)
 }

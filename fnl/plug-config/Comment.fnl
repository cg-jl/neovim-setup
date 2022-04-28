(let [ Comment (require :Comment) ] (Comment.setup {
  :optleader {
    :line :gc
    :block :gr
  }
  :mappings {
    :basic true

    ; gco, gcO, gcA (for insert-mode inserting comments)
    :extra true

    ; g>, g<
    :extended true
  }
}))

; set filetypes
(let [ ft (require :Comment.ft) ]
  (ft.set :fennel ";%s")
  (ft.set :lua [ :--%s "--[[%s]]" ])
)

nil

(local autopairs (require :nvim-autopairs))

  (autopairs.setup {
    :check_ts true ; use treesitter
    :ts_config {
    }
   })


(local ts-conds (require :nvim-autopairs.ts-conds))

  (autopairs.add_rules [ (-> (Rule :% :% :lua) (: :with_pair (ts-conds.is_ts_node [:string :comment])))
   (-> (Rule :$ :$ :lua) (: :with_pair (ts-conds.is_not_ts_node [:function])))
  ])


;; copied from TJDevries!!! 

(local Job (require :plenary.job))

(local source {
  :new (fn source-new []
    (setmetatable { :cache {} } { :__index source })
  )
  :complete (fn source-complete [self _ callback]
    (local bufnr (vim.api.nvim_get_current_buf))

    ; This just makes sure that we only hit the GH API once per session
    (if (not (. self.cache bufnr))
      (let [job (: Job :new {
        1 :gh
        2 :issue
        3 :list
        4 :--limit
        5 :1000
        6 :--json
        7 "title,number,body"

        :on_exit (fn [job]
          (let [result (: job :result)
                (ok? parsed) (pcall vim.json.decode (table.concat result ""))]
            (if (not ok?)  (do
              (vim.notify "Failed to parse gh-cli result")
              nil)
              (do 
                (var items {})
                (each [_ gh_item (ipairs parsed)]
                  (tset gh_item :body (string.gsub (or gh_item.body "") "\r" ""))
                  (table.insert items {
                    :label (string.format "#%s" gh_item.number)
                    :documentation {
                      :kind :markdown
                      :value (string.format "# %s\n\n%s" gh_item.title gh_item.body)
                    }
                  })
                )
                (callback { : items :isIncomplete false })
                (tset self.cache bufnr items)
                ))
          )
        )
      })] (: job :start)
      )
     (callback { :items (. self.cache bufnr) :isIncomplete false })
  ))
  :get_trigger_characters #:#
  :is_available #(= vim.bo.filetyme :gitcommit)
})

(->> (source.new)
      ((. (require :cmp) :register_source) :gh_issues ))
    


nil

(local dap (require :dap))

(macro add-adapter [name config]
  `(tset dap.adapters ,name ,config))

; using lldb vscode

(add-adapter :lldb {
    :type :executable
    :command :/usr/bin/lldb-vscode
    :name :lldb
  })

(add-adapter :rust-lldb {
    :type :executable
    :command :/home/gsus/.cargo/bin/rust-lldb
    :name :rust-lldb
})
(fn ask-executable []
  (vim.fn.input "Path to executable: " (.. (vim.fn.getcwd) :/) :file))
(fn set-args [name args]
  (tset dap.configurations name 1 :args args))

(macro mkconf [override_type?]
  (let [ ty (or override_type? :lldb) ]
    `{
  :name :Launch
  :type ,ty
  :request :launch
  :program ask-executable
  :cwd "${workspaceFolder}"
  :stopOnEntry true
  :args []
  :runInTerminal false
    }
  ))

(let [ normal-config (mkconf)
       rust-config (mkconf :rust-lldb) ]
(doto dap.configurations
    (tset :c [normal-config])
    (tset :cpp [normal-config])
    (tset :rust [rust-config])
))


{ :set_args set-args }

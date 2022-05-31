
(local dap (require :dap))

; using lldb vscode

(tset dap.adapters :lldb {
  :type :executable
  :command :/usr/bin/lldb-vscode
  :name :lldb
})

(let [ lldb-config {
  :name :Launch
  :type :lldb
  :request :launch
  :program (fn [] (vim.fn.input "Path to executable: " (.. (vim.fn.getcwd) :/) :file))
  :cwd "${workspaceFolder}"
  :stopOnEntry true
  :args []
  :runInTerminal false
  ; if you use runInTerminal and resize the terminal window, lldb-vscode will receive
  ; a SIGWINCH signal
;  :postRunCommands ["process handle -p true -s false -n false SIGWINCH"]
  } ]
  (doto dap.configurations
    (tset :c [lldb-config])
    (tset :cpp [lldb-config])
    (tset :rust [lldb-config])
  )

)

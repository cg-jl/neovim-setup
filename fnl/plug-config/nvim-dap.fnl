(local dap (require :dap))

(fn dap-config [configs]
  (each [name tbl (pairs configs)]
    (tset dap.adapters name tbl)))

(dap-config {:rust {:type :executable
                    :attach {:pidProperty :pid
                             :pidSelect :ask
                             }
                    :command :lldb-vscode
                    :env {:LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY :YES
                          }
                    :name :lldb
                    }
             })

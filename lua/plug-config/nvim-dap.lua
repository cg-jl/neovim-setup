local dap = require("dap")
local function dap_config(configs)
  for name, tbl in pairs(configs) do
    dap.adapters[name] = tbl
  end
  return nil
end
return dap_config({rust = {attach = {pidProperty = "pid", pidSelect = "ask"}, command = "lldb-vscode", env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"}, name = "lldb", type = "executable"}})

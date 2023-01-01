local dap = require 'dap'

dap.adapters.lldb = {
    type = 'executable',
    command = '/home/gsus/.local/bin/lldb-vscode',
    env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = 'YES',
    },
    name = 'lldb',
}

dap.configurations.rust = {
    name = 'Debug Rust',
    type = 'lldb',
    request ='launch',
    program = '${workspaceFolder}/target/debug/${workspaceFolderBasename}',
    stopOnEntry = false,
}


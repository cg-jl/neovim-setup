local nvim_lsp = require("lspconfig")
local completion = require("completion")
local lsp_status = require("lsp-status")
local utils = require("utils")
local lsp_util = require("lspconfig/util")
local function on_attach(client)
  do
    local _0_0 = client
    completion.on_attach(_0_0)
    lsp_status.on_attach(_0_0)
  end
  return nil
end
lsp_status.config({current_function = true})
lsp_status.register_progress()
vim.cmd("\nfunction! LspStatus() abort\n  if luaeval('#vim.lsp.buf_get_clients() > 0')\n    return luaeval(\"require('lsp-status').status()\")\n  endif\nreturn ''\nendfunction")
local default_options = {capabilities = lsp_status.capabilities, on_attach = on_attach}
nvim_lsp.rust_analyzer.setup(utils["merge-tables"](default_options, {settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}}))
nvim_lsp.ccls.setup(default_options)
nvim_lsp.hls.setup(default_options)
nvim_lsp.gopls.setup(default_options)
return nvim_lsp.clangd.setup(utils["merge-tables"](default_options, {settings = {root_dir = lsp_util.root_pattern("build", "compile_commands.json")}}))

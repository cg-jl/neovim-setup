package.preload["fnl.keys"] = package.preload["fnl.keys"] or function(...)
  vim.keymap.set("i", "<c-j>", "\\<c-n>", {expr = true, noremap = true, silent = true})
  vim.keymap.set("i", "<c-j>", "\\<c-p>", {expr = true, noremap = true, silent = true})
  vim.keymap.set("n", "<m-j>", "<c-w>j", {noremap = true, silent = true})
  vim.keymap.set("n", "<m-k>", "<c-w>k", {noremap = true, silent = true})
  vim.keymap.set("n", "<m-h>", "<c-w>h", {noremap = true, silent = true})
  vim.keymap.set("n", "<m-l>", "<c-w>l", {noremap = true, silent = true})
  vim.keymap.set("i", "jk", "<esc>", {noremap = true, silent = true})
  vim.keymap.set("v", "jk", "<esc>", {noremap = true, silent = true})
  vim.keymap.set("i", "<tab>", "pumvisible() ? \"\\<c-n>\" : \"\\<tab>\"", {expr = true, noremap = true, silent = true})
  vim.keymap.set("v", "<", "<gv", {noremap = true, silent = true})
  vim.keymap.set("v", ">", ">gv", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<c-j>", "<cmd>cprev<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<c-k>", "<cmd>cnext<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>j", "<cmd>lprev<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>k", "<cmd>lnext<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>rc", "<cmd>lua require('main')<cr>", {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.theme"] = package.preload["fnl.plug-config.theme"] or function(...)
  local utils = require("fnl.utils")
  utils["set-globals"]({sonokai_style = "espresso"})
  vim.cmd("colorscheme sonokai")
  vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")
  vim.cmd("hi! EndOfBuffer ctermbg=NONE guibg=NONE")
  return nil
end
package.preload["fnl.plug-config.keys.git-worktree"] = package.preload["fnl.plug-config.keys.git-worktree"] or function(...)
  vim.keymap.set("n", "<leader>gw", "<cmd>Telescope git_worktree git_worktrees<cr>", {noremap = true, silent = true})
  return vim.keymap.set("n", "<leader>gwn", "<cmd>Telescope git_worktree create_git_worktree<cr>", {noremap = true, silent = true})
end
package.preload["fnl.plug-config.keys.barbar"] = package.preload["fnl.plug-config.keys.barbar"] or function(...)
  vim.keymap.set("n", "<leader>bp", "<cmd>BufferPick<cr>", {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.keys.nvim-tree"] = package.preload["fnl.plug-config.keys.nvim-tree"] or function(...)
  vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>", {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.keys.lsp-trouble"] = package.preload["fnl.plug-config.keys.lsp-trouble"] or function(...)
  vim.keymap.set("n", "<leader>ll", "<cmd>TroubleToggle<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>lw", "<cmd>TroubleWorkspaceToggle<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>ld", "<cmd>TroubleDocumentToggle<cr>", {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.keys.vim-fugitive"] = package.preload["fnl.plug-config.keys.vim-fugitive"] or function(...)
  vim.keymap.set("n", "<leader>gs", "<cmd>G<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.keys.lsp"] = package.preload["fnl.plug-config.keys.lsp"] or function(...)
  vim.keymap.set("n", "<space>,", vim.diagnostic.goto_prev, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>;", vim.diagnostic.goto_next, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>d", vim.lsp.buf.definition, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>h", vim.lsp.buf.hover, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>m", vim.lsp.buf.rename, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>r", vim.lsp.buf.references, {noremap = true, silent = true})
  vim.keymap.set("n", "<space>s", vim.lsp.buf.document_symbol, {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.keys.fzf"] = package.preload["fnl.plug-config.keys.fzf"] or function(...)
  vim.keymap.set("n", "<leader>ff", "<cmd>Files<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>rg", "<cmd>Rg<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>fh", "<cmd>History<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>fc", "<cmd>Commits<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>fb", "<cmd>Buffers<cr>", {noremap = true, silent = true})
  return nil
end
package.preload["fnl.plug-config.git-worktree"] = package.preload["fnl.plug-config.git-worktree"] or function(...)
  local git_worktree = require("git-worktree")
  return git_worktree.setup({})
end
package.preload["fnl.plug-config.nvim-cmp/main"] = package.preload["fnl.plug-config.nvim-cmp/main"] or function(...)
  do end (require("cmp_nvim_lsp")).setup()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local function _32_(args)
    return vim.fn["vsnip#anonymous"](args.body)
  end
  cmp.setup({min_length = 0, mapping = {["<c-n>"] = cmp.mapping.select_next_item(), ["<leader>c"] = cmp.mapping.complete(), ["<c-e>"] = cmp.mapping.close(), ["<c-p>"] = cmp.mapping.select_prev_item()}, snippet = {expand = _32_}, sources = cmp.config.sources({{name = "gh_source"}, {name = "nvim_lsp"}}), experimental = {ghost_text = true}, view = {entries = "native"}, formatting = {format = lspkind.cmp_format({with_text = false, maxwidth = 50})}})
  do end (require("colorbuddy")).setup()
  return nil
end
package.preload["fnl.plug-config.nvim-tree"] = package.preload["fnl.plug-config.nvim-tree"] or function(...)
  local utils = require("fnl.utils")
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup({disable_netrw = true, hijack_netrw = true})
  return nil
end
package.preload["fnl.plug-config.feline"] = package.preload["fnl.plug-config.feline"] or function(...)
  local feline = require("feline")
  local vi_mode_utils = require("feline.providers.vi_mode")
  local feline_lsp = require("feline.providers.lsp")
  local utils = require("fnl.utils")
  local function vi_mode_provider()
    local mode_alias = {n = "NORMAL", no = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE", ["\22"] = "V-BLOCK", c = "COMMAND", cv = "COMMAND", ce = "COMMAND", R = "REPLACE", Rv = "REPLACE", s = "SELECT", S = "SELECT", ["\19"] = "SELECT", t = "TERMINAL"}
    return ("\238\152\171 " .. mode_alias[vim.fn.mode()])
  end
  local components = {active = {{}, {}, {}}}
  local lsp_status = require("lsp-status")
  do
    local _17_ = components.active
    do
      local _18_ = (_17_)[1]
      local function _19_()
        return {name = vi_mode_utils.get_mode_highlight_name(), style = "bold", fg = vi_mode_utils.get_mode_color()}
      end
      table.insert(_18_, {provider = "vi_mode", hl = _19_, right_sep = "  ", left_sep = " "})
      table.insert(_18_, {provider = "file_info", hl = {fg = "#ebdbb2", bg = "#3c3836", style = "bold"}, left_sep = {{str = "slant_left", hl = {fg = "#3c3836"}}, {str = " ", hl = {bg = "#3c3836"}}}})
      local function _20_()
        return (vim.fn.getfsize(vim.fn.expand("%:p")) > 0)
      end
      table.insert(_18_, {provider = "position", left_sep = {{str = "slant_left_thin", hl = {bg = "#3c3836"}}, {str = " ", hl = {bg = "#3c3836"}}}, right_sep = {{str = " ", hl = {bg = "#3c3836"}}, {str = "slant_right_2", hl = {bg = "#1d2021", fg = "#3c3836"}}}, hl = {fg = "white", bg = "#3c3836"}, enabled = _20_})
      local function _21_()
        return feline_lsp.diagnostics_exist("info")
      end
      table.insert(_18_, {enabled = _21_, hl = {bg = "#1d2021", fg = "green"}, left_sep = {hl = {bg = "#3c3836", fg = "#1d2021"}, str = "slant_left"}, provider = "diagnostic_info"})
      local function _22_()
        return feline_lsp.diagnostics_exist("hint")
      end
      table.insert(_18_, {enabled = _22_, hl = {bg = "#1d2021", fg = "white"}, left_sep = {hl = {bg = "#1d2021", fg = "#1d2021"}, str = "slant_left"}, provider = "diagnostic_hints"})
      local function _23_()
        return feline_lsp.diagnostics_exist("warn")
      end
      table.insert(_18_, {enabled = _23_, hl = {bg = "#1d2021", fg = "yellow"}, left_sep = {hl = {bg = "#1d2021", fg = "#1d2021"}, str = "slant_left"}, provider = "diagnostic_warnings"})
      local function _24_()
        return feline_lsp.diagnostics_exist("error")
      end
      table.insert(_18_, {enabled = _24_, hl = {bg = "#1d2021", fg = "red"}, left_sep = {hl = {bg = "#1d2021", fg = "#1d2021"}, str = "slant_left"}, provider = "diagnostic_errors"})
    end
    local _25_ = (_17_)[3]
    local function _26_()
      return utils.shorten(85, lsp_status.status())
    end
    local function _27_()
      return (#vim.lsp.buf_get_clients() > 0)
    end
    table.insert(_25_, {provider = _26_, hl = {bg = "#1d2021", fg = "white"}, enabled = _27_})
    local function _28_()
      return {str = " ", hl = {bg = "#3c3836", fg = "NONE"}}
    end
    table.insert(_25_, {provider = "git_branch", hl = {fg = "white", bg = "#3c3836"}, right_sep = _28_, left_sep = {{str = "slant_left_2", hl = {bg = "#1d2021", fg = "#3c3836"}}}})
    table.insert(_25_, {provider = "git_diff_added", hl = {fg = "green", bg = "#3c3836"}, right_sep = {str = " ", hl = {bg = "#3c3836"}}})
    table.insert(_25_, {provider = "git_diff_changed", hl = {fg = "orange", bg = "#3c3836"}, right_sep = {str = " ", hl = {bg = "#3c3836"}}})
    local function _29_()
      local _30_
      if vim.b.gitsigns_status_dict then
        _30_ = " "
      else
        _30_ = ""
      end
      return {str = _30_, hl = {bg = "#3c3836"}}
    end
    table.insert(_25_, {provider = "git_diff_removed", hl = {fg = "red", bg = "#3c3836"}, right_sep = {_29_, {str = "slant_right_2", hl = {fg = "#3c3836"}}}})
    table.insert(_25_, {provider = "line_percentage", hl = {style = "bold"}, right_sep = " ", left_sep = " "})
  end
  return feline.setup({colors = {bg = "#504945", black = "#282828", cyan = "#8ec07c", fg = "#fabd2f", green = "#b8bb26", magenta = "#d3869b", oceanblue = "#458588", orange = "#fe8019", red = "#fb4934", skyblue = "#83a598", violet = "#b16286", white = "#ebdbb2", yellow = "#fabd2f"}, vi_mode_colors = {NORMAL = "#bcae93", OP = "cyan", INSERT = nil, VISUAL = "green", BLOCK = "green", REPLACE = "yellow", ["V-REPLACE"] = "yellow", ENTER = "cyan", MORE = "cyan", SELECT = "magenta", COMMAND = "cyan", SHELL = "skyblue", TERM = "skyblue", NONE = "orange"}, components = components})
end
package.preload["fnl.plug-config.gitsigns"] = package.preload["fnl.plug-config.gitsigns"] or function(...)
  local gs = require("gitsigns")
  return gs.setup()
end
package.preload["fnl.plug-config.treesitter"] = package.preload["fnl.plug-config.treesitter"] or function(...)
  local ts = require("nvim-treesitter.configs")
  ts.setup({highlight = {enable = true}, autopairs = {enable = true}})
  return nil
end
package.preload["fnl.plug-config.hop"] = package.preload["fnl.plug-config.hop"] or function(...)
  local hop = require("hop")
  return hop.setup({})
end
package.preload["fnl.plug-config.nvim-lsp"] = package.preload["fnl.plug-config.nvim-lsp"] or function(...)
  local nvim_lsp = require("lspconfig")
  local lsp_status = require("lsp-status")
  local utils = require("fnl.utils")
  local lsp_util = require("lspconfig/util")
  local coq = require("coq")
  local function on_attach(client)
    do
      local _16_ = client
      lsp_status.on_attach(_16_)
    end
    return nil
  end
  lsp_status.config({current_function = true})
  lsp_status.register_progress()
  local default_options = {on_attach = on_attach, capabilities = utils["merge-tables"](lsp_status.capabilities, vim.lsp.protocol.make_client_capabilities())}
  nvim_lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities(utils["merge-tables"](default_options, {settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}})))
  nvim_lsp.hls.setup(coq.lsp_ensure_capabilities(default_options))
  nvim_lsp.gopls.setup(coq.lsp_ensure_capabilities(default_options))
  nvim_lsp.clangd.setup(coq.lsp_ensure_capabilities(default_options))
  return nvim_lsp.zls.setup(coq.lsp_ensure_capabilities(default_options))
end
package.preload["fnl.plug-config.Comment"] = package.preload["fnl.plug-config.Comment"] or function(...)
  do
    local Comment = require("Comment")
    Comment.setup({optleader = {line = "gc", block = "gr"}, mappings = {basic = true, extra = true, extended = true}})
  end
  do
    local ft = require("Comment.ft")
    ft.set("fennel", ";%s")
    ft.set("lua", {"--%s", "--[[%s]]"})
  end
  return nil
end
package.preload["fnl.plug-config.keys.dap"] = package.preload["fnl.plug-config.keys.dap"] or function(...)
  vim.keymap.set("n", "<leader>bt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>bc", "<cmd>lua require('dap').continue()<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>so", "<cmd>lua require('dap').step_over()<cr>", {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>si", "<cmd>lua require('dap').step_into()<cr>", {noremap = true, silent = true})
  return vim.keymap.set("n", "<leader>repl", "<cmd>lua require('dap').repl.open()<cr>", {noremap = true, silent = true})
end
package.preload["fnl.plug-config.nvim-dap"] = package.preload["fnl.plug-config.nvim-dap"] or function(...)
  local dap = require("dap")
  do end (dap.adapters)["lldb"] = {type = "executable", command = "/usr/bin/lldb-vscode", name = "lldb"}
  dap.adapters["rust-lldb"] = {type = "executable", command = "/home/gsus/.cargo/bin/rust-lldb", name = "rust-lldb"}
  local function ask_executable()
    return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
  end
  local function set_args(name, args)
    dap.configurations[name][1]["args"] = args
    return nil
  end
  do
    local normal_config = {args = {}, cwd = "${workspaceFolder}", name = "Launch", program = ask_executable, request = "launch", runInTerminal = false, stopOnEntry = true, type = "lldb"}
    local rust_config = {args = {}, cwd = "${workspaceFolder}", name = "Launch", program = ask_executable, request = "launch", runInTerminal = false, stopOnEntry = true, type = "rust-lldb"}
    local _15_ = dap.configurations
    _15_["c"] = {normal_config}
    _15_["cpp"] = {normal_config}
    _15_["rust"] = {rust_config}
  end
  return {set_args = set_args}
end
package.preload["fnl.plugins"] = package.preload["fnl.plugins"] or function(...)
  do
    local data_path = vim.fn.stdpath("data")
    local install_path = (data_path .. "/site/pack/packer/start/packer.nvim")
    local expanded_path = vim.fn.glob(install_path)
    if (vim.fn.empty(expanded_path) ~= 0) then
      print("installing packer...")
      vim.api.nvim_command(("!git clone https://github.com/wbthomason/packer.nvim " .. install_path))
      vim.api.nvim_command("packadd packer.nvim")
      vim.api.nvim_command("PackerSync")
    else
    end
  end
  local packer = require("packer")
  local function packer_startup(use)
    use("wbthomason/packer.nvim")
    use("sainnhe/sonokai")
    use("phaazon/hop.nvim")
    use("nvim-treesitter/nvim-treesitter")
    use("kyazdani42/nvim-web-devicons")
    use({requires = {{requires = "nvim-lua/plenary.nvim", "lewis6991/gitsigns.nvim"}}, "famiu/feline.nvim"})
    use({as = "jakt", "~/contrib/jakt/editors/vim"})
    use({opt = false, requires = "kyazdani42/nvim-web-devicons", "kyazdani42/nvim-tree.lua"})
    use("tpope/vim-surround")
    use("tpope/vim-repeat")
    use("tpope/vim-fugitive")
    use("numToStr/Comment.nvim")
    use({run = vim.fn["fzf#install"], "junegunn/fzf"})
    use("junegunn/fzf.vim")
    use("nvim-lua/lsp-status.nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/cmp-vsnip")
    use("elkowar/yuck.vim")
    use({requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "nvim-lua/plenary.nvim"}, "hrsh7th/nvim-cmp"})
    use({requires = "kyazdani42/nvim-web-devicons", "folke/trouble.nvim"})
    use("folke/lsp-colors.nvim")
    use("ARM9/arm-syntax-vim")
    use("tikhomirov/vim-glsl")
    use("harenome/vim-mipssyntax")
    use("petrbroz/vim-glsl")
    use("LnL7/vim-nix")
    use({as = "jakt-syntax", "~/contrib/jakt/editors/vim"})
    use({requires = "kyazdani42/nvim-web-devicons", "romgrk/barbar.nvim"})
    use("lervag/vimtex")
    use("ms-jpq/coq_nvim")
    use("onsails/lspkind-nvim")
    use("tjdevries/colorbuddy.nvim")
    use("ThePrimeagen/git-worktree.nvim")
    local function _14_()
      require("fnl.plug-config.nvim-dap")
      return require("fnl.plug-config.keys.dap")
    end
    use({config = _14_, "mfussenegger/nvim-dap"})
    return nil
  end
  packer.startup(packer_startup)
  require("fnl.plug-config.Comment")
  require("fnl.plug-config.nvim-lsp")
  require("fnl.plug-config.hop")
  require("fnl.plug-config.treesitter")
  require("fnl.plug-config.gitsigns")
  require("fnl.plug-config.feline")
  require("fnl.plug-config.nvim-tree")
  require("fnl.plug-config.nvim-cmp/main")
  require("fnl.plug-config.git-worktree")
  require("fnl.plug-config.keys.fzf")
  require("fnl.plug-config.keys.lsp")
  require("fnl.plug-config.keys.vim-fugitive")
  require("fnl.plug-config.keys.lsp-trouble")
  require("fnl.plug-config.keys.nvim-tree")
  require("fnl.plug-config.keys.barbar")
  require("fnl.plug-config.keys.git-worktree")
  require("fnl.plug-config.theme")
  return nil
end
package.preload["fnl.utils"] = package.preload["fnl.utils"] or function(...)
  local function map(mode, lhs, rhs, more_options_3f)
    local options = {noremap = true, silent = true}
    if more_options_3f then
      options = vim.tbl_extend("force", options, more_options_3f)
    else
    end
    return vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end
  local function is_in_table(tbl, value)
    for _, v in ipairs(tbl) do
      if (v == value) then
        return true
      else
      end
    end
    return false
  end
  local function options(scope, kvpairs)
    local scope_index
    do
      local _3_ = scope
      if (_3_ == "global") then
        scope_index = "o"
      elseif (_3_ == "buffer") then
        scope_index = "bo"
      elseif (_3_ == "window") then
        scope_index = "wo"
      else
        scope_index = nil
      end
    end
    local tset_fn
    if (scope ~= "global") then
      local function _5_(k, v)
        vim[scope_index][k] = v
        vim.o[k] = v
        return nil
      end
      tset_fn = _5_
    else
      local function _6_(k, v)
        vim[scope_index][k] = v
        return nil
      end
      tset_fn = _6_
    end
    for k, v in pairs(kvpairs) do
      tset_fn(k, v)
    end
    return nil
  end
  local function count_true(tbl, filter)
    local count = 0
    for _, v in ipairs(tbl) do
      if filter(v) then
        count = (count + 1)
      else
      end
    end
    return count
  end
  local function reverse_inplace(tbl)
    for k = 1, #tbl do
      tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
    end
    return nil
  end
  local function shorten(maxlen, str)
    if (#str > maxlen) then
      return (string.sub(str, 1, (maxlen - 3)) .. "...")
    else
      return str
    end
  end
  local function make_command(name)
    return (":" .. name .. "<cr>")
  end
  local function map_command(mode, lhs, rhs, more_options_3f)
    return map(mode, lhs, make_command(rhs), more_options_3f)
  end
  local function set_global(key, value)
    vim.g[key] = value
    return nil
  end
  local function set_globals(kvpairs)
    for k, v in pairs(kvpairs) do
      vim.g[k] = v
    end
    return nil
  end
  local function prefix_options(prefixes, kvpairs)
    local tbl = {}
    local built_prefix = (table.concat(prefixes, "_") .. "_")
    for k, v in pairs(kvpairs) do
      tbl[(built_prefix .. k)] = v
    end
    return tbl
  end
  local function env()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
  end
  local function merge_tables(a, b, ...)
    local function is_type(v, type_name)
      return (type(v) == type_name)
    end
    local function both_have_type(a0, b0, type_name)
      return (is_type(a0, type_name) and is_type(b0, type_name))
    end
    local merged = {}
    for k, v in pairs(a) do
      merged[k] = v
    end
    for k, v in pairs(b) do
      local other_value = a[k]
      local _10_
      if both_have_type(v, other_value, "table") then
        _10_ = merge_tables(v, other_value)
      else
        _10_ = v
      end
      merged[k] = _10_
    end
    for i, tbl in ipairs({...}) do
      merged = merge_tables(merged, tbl)
    end
    return merged
  end
  local function _12_(...)
    return map("i", ...)
  end
  return {["is-in-table"] = is_in_table, options = options, map = map, ["map-command"] = map_command, ["set-global"] = set_global, ["set-globals"] = set_globals, ["merge-tables"] = merge_tables, ["make-command"] = make_command, ["prefix-options"] = prefix_options, ["count-true"] = count_true, shorten = shorten, imap = _12_}
end
package.preload["fnl.options"] = package.preload["fnl.options"] or function(...)
  local utils = require("fnl.utils")
  utils.options("global", {hidden = true, encoding = "utf-8", ruler = true, pumheight = 10, cmdheight = 2, splitbelow = true, smarttab = true, wildmode = "list:longest", laststatus = 3, showtabline = 2, showmode = false, backup = false, writebackup = false, updatetime = 300, timeoutlen = 500, clipboard = "unnamedplus", mouse = "nicr", guicursor = "", hlsearch = false, ignorecase = true, smartcase = true, completeopt = "menuone,noinsert,noselect", termguicolors = true})
  utils.options("window", {wrap = false, conceallevel = 0, cursorline = true, number = true, relativenumber = true, signcolumn = "yes", list = false})
  utils.options("buffer", {tabstop = 2, shiftwidth = 2, smartindent = true, autoindent = true, expandtab = true, swapfile = false})
  return nil
end
package.preload["fnl.langs"] = package.preload["fnl.langs"] or function(...)
  return vim.cmd("\naugroup Porth\nau FileReadPost *.porth set ft=porth\naugroup end\n\naugroup LispyC\nau FileReadPost *.lc set ft=lispyc\naugroup end\n\n ")
end
vim.g["mapleader"] = ","
vim.g["python3_host_prog"] = "/usr/bin/python3"
require("fnl.langs")
require("fnl.options")
require("fnl.plugins")
require("fnl.keys")
return nil

-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/gsus/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/gsus/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/gsus/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/gsus/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/gsus/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["arm-syntax-vim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/arm-syntax-vim",
    url = "https://github.com/ARM9/arm-syntax-vim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "https://github.com/tjdevries/colorbuddy.nvim"
  },
  coq_nvim = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/coq_nvim",
    url = "https://github.com/ms-jpq/coq_nvim"
  },
  ["feline.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/feline.nvim",
    url = "https://github.com/famiu/feline.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["git-worktree.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/git-worktree.nvim",
    url = "https://github.com/ThePrimeagen/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  jakt = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/jakt",
    url = "/home/gsus/contrib/jakt/editors/vim"
  },
  ["jakt-syntax"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/jakt-syntax",
    url = "/home/gsus/contrib/jakt/editors/vim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\28\0\0\2\1\1\0\3-\0\0\0009\0\0\0D\0\1\0\1¿\vstatus¡\1\1\0\b\0\r\0\0226\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0B\2\1\0029\3\4\2'\4\6\0=\4\5\0033\3\a\0006\4\b\0009\4\t\0049\6\n\0029\6\v\6\18\a\3\0B\4\3\0019\4\f\0\18\6\2\0002\0\0ÄD\4\2\0\nsetup\14lualine_x\rsections\vinsert\ntable\0\vbase16\ntheme\foptions\15get_config\15lsp-status\flualine\frequire\0" },
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["material.nvim"] = {
    config = { "\27LJ\2\n¥\1\0\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\3B\1\2\0016\1\6\0009\1\a\1'\2\t\0=\2\b\0016\1\6\0009\1\n\1'\3\v\0D\1\2\0\25colorscheme material\bcmd\14palenight\19material_style\6g\bvim\fdisable\1\0\0\1\0\1\19colored_cursor\2\nsetup\rmaterial\frequire\0" },
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/material.nvim",
    url = "https://github.com/marko-cerovac/material.nvim"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-base16",
    url = "https://github.com/RRethy/nvim-base16"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\nY\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0D\0\2\0\29fnl.plug-config.keys.dap\29fnl.plug-config.nvim-dap\frequire\0" },
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["symbols-outline.nvim"] = {
    config = { "\27LJ\2\nn\0\0\6\0\a\0\b6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0D\0\5\0\1\0\2\vsilent\2\fnoremap\2\28<cmd>SymbolsOutline<cr>\14<leader>s\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-glsl",
    url = "https://github.com/petrbroz/vim-glsl"
  },
  ["vim-mipssyntax"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-mipssyntax",
    url = "https://github.com/harenome/vim-mipssyntax"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-nix",
    url = "https://github.com/LnL7/vim-nix"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  vimtex = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["yuck.vim"] = {
    loaded = true,
    path = "/home/gsus/.local/share/nvim/site/pack/packer/start/yuck.vim",
    url = "https://github.com/elkowar/yuck.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0D\0\2\0\29fnl.plug-config.keys.dap\29fnl.plug-config.nvim-dap\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: material.nvim
time([[Config for material.nvim]], true)
try_loadstring("\27LJ\2\n¥\1\0\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\3B\1\2\0016\1\6\0009\1\a\1'\2\t\0=\2\b\0016\1\6\0009\1\n\1'\3\v\0D\1\2\0\25colorscheme material\bcmd\14palenight\19material_style\6g\bvim\fdisable\1\0\0\1\0\1\19colored_cursor\2\nsetup\rmaterial\frequire\0", "config", "material.nvim")
time([[Config for material.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\28\0\0\2\1\1\0\3-\0\0\0009\0\0\0D\0\1\0\1¿\vstatus¡\1\1\0\b\0\r\0\0226\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0B\2\1\0029\3\4\2'\4\6\0=\4\5\0033\3\a\0006\4\b\0009\4\t\0049\6\n\0029\6\v\6\18\a\3\0B\4\3\0019\4\f\0\18\6\2\0002\0\0ÄD\4\2\0\nsetup\14lualine_x\rsections\vinsert\ntable\0\vbase16\ntheme\foptions\15get_config\15lsp-status\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: symbols-outline.nvim
time([[Config for symbols-outline.nvim]], true)
try_loadstring("\27LJ\2\nn\0\0\6\0\a\0\b6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0D\0\5\0\1\0\2\vsilent\2\fnoremap\2\28<cmd>SymbolsOutline<cr>\14<leader>s\6n\bset\vkeymap\bvim\0", "config", "symbols-outline.nvim")
time([[Config for symbols-outline.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

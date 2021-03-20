" plugins go first!
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

if !exists('g:vscode')

  let g:gruvbox_italic=1
  set termguicolors
  colorscheme gruvbox
  set background=dark
  
  source $HOME/.config/nvim/plug-config/init.vim
  source $HOME/.config/nvim/themes/lightline.vim

  runtime! keymap/dvorak.vim

  hi CursorLine guibg=#1d2021
else
  source $HOME/.config/nvim/vscode/settings.vim
  source $HOME/.config/nvim/plug-config/easymotion.vim
endif


" plugins go first!
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

let g:gruvbox_italic=1
set termguicolors
colorscheme gruvbox
set background=dark

source $HOME/.config/nvim/plug-config/init.vim

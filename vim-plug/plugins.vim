" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')


" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" tpope essentials
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" theming
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'

" FZF && vim-rooter
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" completions
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }


call plug#end()

let g:coc_global_extensions = [ 'coc-explorer', 'coc-prettier', 'coc-python', 'coc-marketplace' ]

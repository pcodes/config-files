set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" PLUGINS
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-python/python-syntax'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'valloric/youcompleteme'
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'
Plugin 'raimondi/delimitmate'
Plugin 'tpope/vim-endwise'
Plugin 'majutsushi/tagbar'
Plugin 'nanotech/jellybeans.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tmux-plugins/vim-tmux'

" This needs to load last to get all dev icons
Plugin 'ryanoasis/vim-devicons'

" END PLUGINS
call vundle#end()            
filetype plugin indent on

" VISUALS
colorscheme gruvbox
set background=dark
syntax on
let g:airline_theme='jellybeans'
set number "Show line numbers
set noshowmode "Hide the second mode (airline already has it)
set laststatus=2 "Always show statusline
let g:airline_powerline_fonts = 1 "Enable powerline fonts
set encoding=UTF-8

" TAB PAGES
map <F6> :tabn<CR>
map <F5> :vsplit <bar> :wincmd l<bar> :wincmd T<CR>
map <F4> :tabp<CR>
map <F3> :vsplit<CR>

" TAB/SPACE SETTINGS
set tabstop=4 expandtab

" NERDTREE SETTINGS
map <F2> :NERDTreeToggle<CR>

" Fix SQL Bug
let g:ycm_autoclose_preview_window_after_completion = 1
let g:python_highlight_all = 1

" CTAGS TAGBAR
map <F8> :TagbarToggle<CR>

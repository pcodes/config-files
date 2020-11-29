"--------------------------------
" Plugins
"--------------------------------
call plug#begin('~/.vim/plugged')

" ---UI plugins---
" A sweet status bar
Plug 'vim-airline/vim-airline'
" Themes for a sweet status bar
Plug 'vim-airline/vim-airline-themes'
" Material colorscheme
Plug 'kaicataldo/material.vim'
" Onedark colorscheme
Plug 'joshdick/onedark.vim'
" Tmux status line generator
Plug 'edkolev/tmuxline.vim'
"Smooth scrolling
Plug 'psliwka/vim-smoothie'
" File explorer
Plug 'scrooloose/nerdtree'
" File explorer + git
Plug 'Xuyuanp/nerdtree-git-plugin'

" ---Search plugins---
" Fuzzy file finder (CLI plugin and vim plugin)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Better search functionality
Plug 'junegunn/vim-slash'

" ---Auto-complete plugins---
" LSP-based auto-complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Who doesn't love code snippets
Plug 'honza/vim-snippets'
" Auto-close those brackets
Plug 'jiangmiao/auto-pairs'

" ---Misc---
" Better commenting
Plug 'preservim/nerdcommenter'
" Easily change surrounging characters
Plug 'tpope/vim-surround'
" This needs to load last, adds extra icons
Plug 'ryanoasis/vim-devicons'
call plug#end()

"--------------------------------
" General Vim Settings
"--------------------------------
set autoindent
set smartindent
set autoread
set autowriteall
set completeopt-=preview
set encoding=utf-8
set noshowmode
set expandtab
set list
set listchars=tab:\|\ ,trail:▫
set nospell                       " disable spelling
set nowrap
set number
set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4
set title
" neovim specific settings
if has('nvim')
    " Set the Python binaries neovim is using. Please note that you will need to
    " install the neovim package for these binaries separately like this for
    " example:
    " pip3.6 install -U neovim
    let g:python_host_prog = '/Users/patcody/.pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = '/Users/patcody/.pyenv/versions/neovim3/bin/python'
endif

" Enable mouse if possible
if has('mouse')
    set mouse=a
endif


"--------------------------------
" UI Settings
"--------------------------------

" Allow vim to set a custom font or color for a word
syntax enable
" Enable truecolor
set termguicolors

" Set colorscheme
let g:material_theme_style = 'default'
colorscheme material

" Set airline theme and enable powerline fonts
let g:airline_theme='material'
let g:airline_powerline_fonts=1
" Disable the airline-tmux compatibility (conflicts with tmuxline)
let g:airline#extensions#tmuxline#enabled = 0
" Enable the airline tabline
let g:airline#extensions#tabline#enabled = 1
" Change tabline display settings
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Fix the gutter background colors
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
highlight GitGutterDelete ctermfg=1 ctermbg=0
highlight GitGutterChangeDelete ctermfg=1 ctermbg=0


"--------------------------------
" Control Settings
"--------------------------------

" Move to next tab
map <F6> :tabn<CR>
" Create new tab
map <F5> :vsplit <bar> :wincmd l<bar> :wincmd T<CR>
" Go to previous tab
map <F4> :tabp<CR>
" Split vertically
map <F3> :vsplit<CR>

"--------------------------------
" CoC Settings
"--------------------------------
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-vimlsp', 'coc-sh', 'coc-markdownlint']
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

let g:airline#extensions#coc#enabled = 1

"--------------------------------
" FZF Settings
"--------------------------------

" Function to either find git root or current folder
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" Command to execute the function
command! ProjectFiles execute 'Files' s:find_git_root()
" Map the command to Ctrl P
nnoremap <c-p> :ProjectFiles<cr>

"--------------------------------
" AutoPairs Settings
"--------------------------------
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'

"--------------------------------
" Nerdtree Settings
"--------------------------------
map <F2> :NERDTreeToggle<CR>

" Open nerdtree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set nocompatible              " be iMproved, required
filetype off                  " required

" ================ Vundle Section ===================
"
"
" 1. Install with `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
" 2. Install Nerfonts from https://github.com/ryanoasis/nerd-fonts

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'             " Vundle plgin manager
Plugin 'altercation/vim-colors-solarized' " Solarized colaour theme
Plugin 'tpope/vim-fugitive'               " Better git handing
Plugin 'vim-scripts/tComment'             " T-Comment for faster commenting
Plugin 'SirVer/ultisnips'                 " Ultisnips for snippets
Plugin 'honza/vim-snippets'               " Base snippets
Plugin 'godlygeek/tabular'                " Tabular util
Plugin 'ctrlpvim/ctrlp.vim'               " Control-P file explorer
Plugin 'scrooloose/nerdtree.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/taglist.vim'          " Taglist
Plugin 'majutsushi/tagbar'                " Tagbar
Plugin 'ryanoasis/vim-devicons'           " Dev icons
Plugin 'mhinz/vim-startify'               " Dev icons
Plugin 'othree/javascript-libraries-syntax.vim' " Javascript Syntax Helpers

call vundle#end()
filetype plugin indent on


" ================ Buffer Shortcuts =================
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>"


" ================ Tab shortcots ====================
"
map <silent> tt :tabnew<cr>   " Create Tab
map <silent> -- :tabp<cr>     " Previous tab
map <silent> == :tabn<cr>     " Next Tab

map <silent> ,1 :tabn 1<cr> " Use numbers to pick the tab you want (like iTerm)
map <silent> ,2 :tabn 2<cr>
map <silent> ,3 :tabn 3<cr>
map <silent> ,4 :tabn 4<cr>
map <silent> ,5 :tabn 5<cr>
map <silent> ,6 :tabn 6<cr>
map <silent> ,7 :tabn 7<cr>
map <silent> ,8 :tabn 8<cr>
map <silent> ,9 :tabn 9<cr>


" ================ Split window shortcuts ===========
"
nnoremap <silent> vv <C-w>v " Split vert.
nnoremap <silent> ss <C-w>s " Split hori.


" ================ Tabularize Shortcuts =============
"
nmap \| :Tabularize /
vmap \| :Tabularize /


" ================ Indentation ======================
"
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab


" ================ Folds ============================
"
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set foldmethod=marker


" ================ Solarized Plugin =================
"
syntax enable
set background=dark
colorscheme solarized


" ================ Solarized Plugin =================
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit='vertical' " If you want :UltiSnipsEdit to split your window.


" ================ Set Sane Defaults ================
"
let mapleader=","
set number      " Numbers on left
set relativenumber
set ignorecase  " Ignore case
set smartcase 
set laststatus=2



" ================ Smarter Commenting ===============
"
map <leader>c <c-_><c-_>


" ================ Ariline Config ===================
"
let g:airline_theme='solarized'
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_branch_prefix = '⭠ '
let g:airline_readonly_symbol = '⭤'
let g:airline_linecolumn_prefix = '⭡'

let g:airline#extensions#tabline#enabled = 1            " 
let g:airline#extensions#tabline#left_sep = '⮀'         " Smarter tab lines
let g:airline#extensions#tabline#left_alt_sep = '⮁'     "

let g:airline_powerline_fonts = 1


" ================ NERDTree Config ==================
"
nmap \\ :NERDTreeToggle<CR>:NERDTreeMirror<CR>


" ================ Search ===========================
"
nnoremap // :nohlsearch<CR>


" ================ Taglist ==========================
"
nnoremap <silent> <leader>t :TagbarToggle<CR>


" ========== Persistant Undo Between Sessions =======
"
set undofile


" ========== Set No Swap Fle ========================
"
set noswapfile
set undodir=~/.vim/backups

" ================ Nerd Fonts =======================
"
set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

" ================ Improved Javascript ==============
"
let g:used_javascript_libs = 'angularjs,jquery,angularui,angularuirouter,vue'

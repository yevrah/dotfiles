set nocompatible              " be iMproved, required
filetype off                  " required


" ================ Vundle Section =================== {{{1
"
"
" 1. Install with `git clone https://github.com/VundleVim/Vundle.vim.git \
"                   ~/.vim/bundle/Vundle.vim`
" 2. Install Nerfonts from https://github.com/ryanoasis/nerd-fonts
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'             " Vundle plugin manager


" PLUGINS: General Vim Improvements {{{2
Plugin 'vim-scripts/tComment'             " T-Comment for faster commenting
Plugin 'godlygeek/tabular'                " Tabular util
Plugin 'ctrlpvim/ctrlp.vim'               " Control-P file explorer:let g:UltiSnipsListSnippets='<c-l>'
Plugin 'scrooloose/nerdtree.git'
Plugin 'majutsushi/tagbar'                " Tagbar
Plugin 'mhinz/vim-startify'               " New Start Screen
Plugin 'skwp/vim-easymotion'

" PLUGINS: Vim UI {{{2
Plugin 'altercation/vim-colors-solarized' " Solarized colaour theme
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'           " Dev icons

" PLUGINS: Snippets Support {{{2
Plugin 'SirVer/ultisnips'                 " Ultisnips for snippets
Plugin 'honza/vim-snippets'               " Base snippets

" PLUGINS: Javascript {{{2
Plugin 'marijnh/tern_for_vim'
Plugin 'othree/javascript-libraries-syntax.vim' " Javascript Syntax Helpers

" PLUGINS: Git  {{{2
Plugin 'tpope/vim-fugitive'               " Better git handing
Plugin 'gregsexton/gitv'
Plugin 'mattn/gist-vim'
Plugin 'airblade/vim-gitgutter.git'

" PLUGINS: Review these plugins on local {{{2
if has('mac')
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'vim-voom/VOoM'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/DrawIt'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
endif

"Plugin 'ervandew/supertab'                " Supertab plugin


" ================ End Vundle Section =============== {{{1
call vundle#end() 
filetype plugin indent on


" ################ START VIM SETTINGS ############### {{{1
"  _ _  _  _   _    __  ___  ___  ___  _  _  _  __  __ 
" | | || || \_/ |  / _|| __||_ _||_ _|| || \| |/ _|/ _|
" | V || || \_/ |  \_ \| _|  | |  | | | || \\ ( |_n\_ \
"  \_/ |_||_| |_|  |__/|___| |_|  |_| |_||_|\_|\__/|__/
"


" ================ buffer shortcuts ================="{{{1
"
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>


" ================ Spelling Options ================="{{{1
"
set complete+=kspell " auto complete with C-X C-K
set spelllang=en_us
set spell


" ================ Tab shortcots ===================="{{{1
"
nnoremap <silent> tt :tabnew<cr>   " Create Tab
nnoremap <silent> -- :tabp<cr>     " Previous tab
nnoremap <silent> == :tabn<cr>     " Next Tab

" Use numbers to pick the tab you want (like iTerm)
nnoremap <silent> <leader>1 :tabn 1<cr> 
nnoremap <silent> <leader>2 :tabn 2<cr>
nnoremap <silent> <leader>3 :tabn 3<cr>
nnoremap <silent> <leader>4 :tabn 4<cr>
nnoremap <silent> <leader>5 :tabn 5<cr>
nnoremap <silent> <leader>6 :tabn 6<cr>
nnoremap <silent> <leader>7 :tabn 7<cr>
nnoremap <silent> <leader>8 :tabn 8<cr>
nnoremap <silent> <leader>9 :tabn 9<cr>


" ================ Split window shortcuts ==========="{{{1
"
nnoremap <silent> vv <C-w>v " Split vert.
nnoremap <silent> ss <C-w>s " Split hori.

nnoremap <C-J> <C-W><C-J> " Instead of ctrl-w then j, it’s just ctrl-j:
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" ================ Indentation ======================"{{{1
"
set autoindent
set smartindent
set smarttab
set expandtab

set shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4


" ================ Set Sane Defaults ================"{{{1
"
let mapleader=","
let &colorcolumn=join(range(81,999),",")
set number      " Numbers on left
set relativenumber
set ignorecase  " Ignore case
set smartcase 
set laststatus=2
set autowriteall  " Save buffers when lose focus
set backspace=2 " Make backspace work on Mac 


" ================ Search ==========================="{{{1
"
nnoremap // :nohlsearch<CR>


" ================ Persistant Undo =================="{{{1
"
set undofile
set undodir=~/.vim/backups


" ================ Font Settings ===================="{{{1
"
set encoding=utf8
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\:h12


" ================ Folds ============================"{{{1
"
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set foldmethod=marker
hi Folded term=bold cterm=NONE ctermfg=lightblue "ctermbg=NONE


" ================ Modelines========================="{{{1
"
set modeline
set modelines=5

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


" ================ emenu - experimental ============="{{{1
"

" YOU CAN MANUALLY TRIGGER MENU COMPLETION BY INVOKING TAB COMPLETION ON THE
" :EMENU COMMAND, BY DOING :EMENU<SPACE><TAB>

" Enable smart command line completion on <Tab> (enable listing all possible
" choices, and navigating the results with <Up>, <Down>, <Left>, <Right>, and
" <Enter>)
set wildmenu

" Make repeated presses cycle between all matching choices
set wildmode=full

" Load the default menus (this would happen automatically in gvim, but not in
" terminal vim)
" TODO: Replace with custom menu
source $VIMRUNTIME/menu.vim



" ################ START PLUGINS CONFIG############## {{{1
"  ___ _    _ _  __  _  _  _  __     __ _  _  _  ___  _  __ 
" | o \ |  | | |/ _|| || \| |/ _|   / _/ \| \| || __|| |/ _|
" |  _/ |_ | U ( |_n| || \\ |\_ \  ( (( o ) \\ || _| | ( |_n
" |_| |___||___|\__/|_||_|\_||__/   \__\_/|_|\_||_|  |_|\__/
"



" ================ Improved Javascript =============="{{{1
"
let g:used_javascript_libs = 'angularjs,jquery,angularui,angularuirouter,vue'


" ================ NERDTree and Tagbar =============="{{{1
"
nmap \\ :NERDTreeToggle<CR>:NERDTreeMirror<CR>:TagbarToggle<CR>
autocmd FileType nerdtree  map <buffer> <Tab> <c-w>l " Tab out to main buffer
autocmd FileType tagbar  map <buffer> <Tab> <c-w>h " Tab out to main buffer

nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>

" ================ Ariline Config ==================="{{{1
"
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1            " 
let g:airline_powerline_fonts = 1

" ================ Solarized Plugin ================="{{{1
"
syntax enable
set background=dark
colorscheme solarized


" ================ Ultisnips Plugin ================="{{{1
"

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit='vertical'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[
        \ "bundle/vim-snippets/UltiSnips", 
        \ "/Users/harvey/dotfiles/UltiSnips" ]
let g:UltiSnipsSnippetsDir="/Users/harvey/dotfiles/UltiSnips"

" ================ Tabularize Shortcuts ============="{{{1
"
nmap \| :Tabularize /
vmap \| :Tabularize /

" Some tabularise shortcuts
"      Align first = sign, run :Tabularize =
"                          or  :Tabularize == if you don't need spaces
" NOTES: This has to load after plugin is loaded, hence the autocmd
autocmd VimEnter * AddTabularPattern! = /^[^=]*\zs=
autocmd VimEnter * AddTabularPattern! == /^[^=]*\zs=/r0c0l0

" ================ Smarter Commenting ==============="{{{1
"
map <leader>c <c-_><c-_>

" ================ Startify Config =================="{{{1
"
let g:ctrlp_reuse_window  = 'startify' " Alow ctrlp to use startify window


" ================ Ctrl-P Config ===================="{{{1
"
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'


" ================ Easymotion Config ================"{{{1
"

call EasyMotion#InitOptions({
 \   'leader_key'      : '<Leader>'
 \ , 'keys'            : 'abcdefghijklmnopqrstuvwxyz'
 \ , 'do_shade'        : 1
 \ , 'grouping'        : 1
 \ , 'do_mapping'      : 1
 \ })

" ================ Fugitive Config =================="{{{1
"
nnoremap <silent> ,dg :diffget<CR>
nnoremap <silent> ,dp :diffput<CR>


" ================ Syntastic Config ================="{{{1
"

let g:syntastic_enable_signs=1 " Mark syntax errors with :signs
let g:syntastic_auto_jump=0 " Auto jump to the error when saving the file
let g:syntastic_auto_loc_list=1 " Show the error list automatically
let g:syntastic_quiet_messages={'level': 'warnings'} " Don't care about warnings
let g:syntastic_enable_perl_checker=0 " Perl checker


" ================ YouCompleteMe ===================="{{{1
"
" These settings prevent YCM from clashing with UltiSnips

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" YCM gives you popups and splits by default that some people might 
" not like, so these should tidy it up a bit for you.

" let g:ycm_add_preview_to_completeopt=0
" let g:ycm_confirm_extra_conf=0
" set completeopt-=preview
"
"
" Useful keymapes to enable/disable
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR> " turn off YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR> " turn on YCM


" Fixes error messages when typing in some filetypes
"" Do not display "Pattern not found" messages during YouCompleteMe completion
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
try
  set shortmess+=c
catch /E539: Illegal character/
endtry


" ================ dbext ============================"{{{1
"

" Any number of profiles (connections) can be configured using this basic format:
" let g:dbext_default_profile_<profile_name> = '<connection string>'
"
" For example:
"
" MySQL
" let g:dbext_default_profile_mysql_local =
" 'type=MYSQL:user=root:passwd=whatever:dbname=mysql'
"
" SQLite
" let g:dbext_default_profile_sqlite_for_rails =
" 'type=SQLITE:dbname=/path/to/my/sqlite.db'
"
" Microsoft SQL Server
" let g:dbext_default_profile_microsoft_production =
" 'type=SQLSRV:user=sa:passwd=whatever:host=localhost'

let g:dbext_default_profile_lk = 'type=MYSQL:user=www:passwd=www:dbname=freeol'
let g:dbext_default_profile_piq = 'type=MYSQL:user=www:passwd=www:dbname=clubsDB'


filetype off                  " required

" ################ VUNDLE SECTION ################### {{{1
"

"
" 1. Install with `git clone https://github.com/VundleVim/Vundle.vim.git \
"                   ~/.vim/bundle/Vundle.vim`
" 2. Install Nerdfonts from https://github.com/ryanoasis/nerd-fonts
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'             " Vundle plugin manager

" PLUGINS: Vim UI {{{2
Plugin 'altercation/vim-colors-solarized' " Solarized colour theme
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" PLUGINS: General Vim Improvements {{{2
Plugin 'vim-scripts/tComment'             " T-Comment for faster commenting
Plugin 'godlygeek/tabular'                " Tabular util
Plugin 'vim-scripts/YankRing.vim'
Plugin 'majutsushi/tagbar'                " Tagbar
Plugin 'airblade/vim-rooter'              " Set Project Root to something sane!
Plugin 'mileszs/ack.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-dispatch'

" PLUGINS: Nerdtree Related
Plugin 'scrooloose/nerdtree.git'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'janlay/NERD-tree-project'
" Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

Plugin 'mhinz/vim-startify'               " New Start Screen
Plugin 'skwp/vim-easymotion'

" PLUGINS: Tags {{{2
Plugin 'craigemery/vim-autotag'

" PLUGINS: Ctrl-P {{{2
Plugin 'ctrlpvim/ctrlp.vim'               " Control-P file explorer:let g:UltiSnipsListSnippets='<c-l>'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'ivalkeen/vim-ctrlp-tjump'

" PLUGINS: Snippets Support {{{2
Plugin 'SirVer/ultisnips'                 " Ultisnips for snippets
Plugin 'honza/vim-snippets'               " Base snippets

" PLUGINS: Javascript {{{2
Plugin 'marijnh/tern_for_vim'
Plugin 'othree/javascript-libraries-syntax.vim' " Javascript Syntax Helpers

" PLUGINS: HTML5 {{{2
Plugin 'jvanja/vim-bootstrap4-snippets'
Plugin 'othree/html5-syntax.vim'
Plugin 'othree/html5.vim'

" PLUGINS: CSS {{{2
"Plugin 'JulesWang/css.vim' " only necessary if your Vim version < 7.4
Plugin 'cakebaker/scss-syntax.vim'

" PLUGINS: Git  {{{2
Plugin 'tpope/vim-fugitive'               " Better git handing
Plugin 'gregsexton/gitv'
Plugin 'airblade/vim-gitgutter.git'

" PLUGINS: Python Related
" Plugin 'lambdalisue/vim-pyenv'
Plugin 'davidhalter/jedi-vim'

" PLUGINS: Review these plugins on local {{{2
if has('mac')
Plugin 'plytophogy/vim-virtualenv'
Plugin 'gbigwood/Clippo'
" Plugin 'jtratner/vim-flavored-markdown'
" Plugin 'nelstrom/vim-markdown-folding'
"Plugin 'gabrielelana/vim-markdown'
Plugin 'vim-voom/VOoM'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/DrawIt'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
Plugin 'neomake/neomake'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'lepture/vim-jinja'
endif

" PLUGINS: Needing to be loaded last
Plugin 'ryanoasis/vim-devicons'           " Dev icons

" PLUGINS: Distraction free
Plugin 'junegunn/goyo.vim'

" ================ End Vundle Section =============== {{{2
call vundle#end()
filetype plugin indent on

" ################ START PLUGINS CONFIG ############# {{{1
"  ___ _    _ _  __  _  _  _  __     __ _  _  _  ___  _  __
" | o \ |  | | |/ _|| || \| |/ _|   / _/ \| \| || __|| |/ _|
" |  _/ |_ | U ( |_n| || \\ |\_ \  ( (( o ) \\ || _| | ( |_n
" |_| |___||___|\__/|_||_|\_||__/   \__\_/|_|\_||_|  |_|\__/
"

" ================ Improved javascript =============="{{{2
"
let g:used_javascript_libs = 'angularjs,jquery,angularui,angularuirouter,vue'

" ================ ACK Search ======================="{{{2
"
if executable('ag')
  let g:ackprg = "ag --nogroup --nocolor --column"
  nnoremap <Leader>a :Ack |
elseif executable('ack') || executable ('ack-grep')
  nnoremap <Leader>a :Ack |
else
  nnoremap <Leader>a :grep |
endif


" ================ Project Root Setup ==============="{{{2
"
let g:rooter_patterns = ['.git', '.git/', '.svn', 'package.json', 'Gemfile', 'Gulpfile.js', 'Gruntfile.js', 'config.rb']
let g:rooter_silent_chdir = 1

" ================ NERDTree and Tagbar =============="{{{2
"
nmap \\ :NERDTreeToggle<CR>:NERDTreeMirror<CR>

" function Sidebars()
"   echo "Hello"
"   NERDTreeToggle
" endfunction
" nmap <C-\> :call Sidebars()


" nmap \\ :NERDTreeToggle<CR>:NERDTreeMirror<CR>:TagbarToggle<CR>

nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>

let NERDTreeIgnore = ['\.pyc$']

if has('mac')
  let g:tagbar_ctags_bin="/usr/local/bin/ctags"
" elseif has('unix')
"   let g:tagbar_ctags_bin=" /usr/bin/ctags"
endif

" NERDTree Project
let g:NTPNames = ['.git*', 'package.json', 'Gemfile', 'Gulpfile.js', 'Gruntfile.js']
let g:NTPNamesDirs = ['.git', '.svn']

" ================ Ariline Config ==================="{{{2
"
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1 " Use tabline
" let g:airline#extensions#tabline#show_tabs = 1 " Always show tabline
" let g:airline#extensions#tabline#show_buffers = 1 " Show buffers when no tabs

" ================ Solarized Plugin ================="{{{2
"
syntax enable
set background=dark
colorscheme solarized
"set t_Co=16


" ================ Ultisnips Plugin ================="{{{2
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

" Listing of snippets
inoremap  <C-e>  <C-R>=UltiSnips#ListSnippets()<cr>
nnoremap  <C-e>  :call UltiSnips#ListSnippets()<cr>


" ================ Tabularize Shortcuts ============="{{{2
"
nmap \| :Tabularize /
vmap \| :Tabularize /

" Some tabularise shortcuts
"      Align first = sign, run :Tabularize =
"                          or  :Tabularize == if you don't need spaces
" NOTES: This has to load after plugin is loaded, hence the autocmd
autocmd VimEnter * AddTabularPattern! = /^[^=]*\zs=
autocmd VimEnter * AddTabularPattern! == /^[^=]*\zs=/r0c0l0

" ================ Smarter Commenting ==============="{{{2
"
map <leader>c <c-_><c-_>

" ================ Startify Config =================="{{{2
"
let g:ctrlp_reuse_window  = 'startify' " Alow ctrlp to use startify window
let g:startify_session_dir='~/.vim/session'
let g:startify_session_persistence = 1 " Automatically save sessions one exit

let g:startify_list_order=[
    \ ['   My sessions:'],
    \ 'sessions',
    \ ['   My most recently used files in the current directory:'],
    \ 'dir',
    \ ['   My most recently used files'],
    \ 'files',
    \ ['   My bookmarks:'],
    \ 'bookmarks',
    \ ['   My commands:'],
    \ 'commands',
\ ]
"
" Close Cleanup
let g:startify_session_before_save = [
    \ 'echo "Cleaning up before saving.."',
    \ 'silent! NERDTreeClose',
    \ 'silent! TagbarClose',
\ ]

let g:startify_bookmarks = [
      \ { 'v': '~/dotfiles/vimrc' },
      \ { 'z': '~/dotfiles/zshrc' },
      \ { 'p': '~/dotfiles/pythonrc.py' },
      \ ]



" ================ Ctrl-P Config ===================="{{{2
"
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

if executable('ag')
  " If the silver searcher is installed
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
elseif executable('find')
  " If unix OS
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
elseif executable('dir')
  " If windows
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'dir %s /-n /b /s /a-d']
endif

" ================ Yankring Config =================="{{{2
"

autocmd VimEnter * nnoremap <leader>yr :YRShow<CR>


" ================ Easymotion Config ================"{{{2
"

call EasyMotion#InitOptions({
 \   'leader_key'      : '<Leader>'
 \ , 'keys'            : 'abcdefghijklmnopqrstuvwxyz'
 \ , 'do_shade'        : 1
 \ , 'grouping'        : 1
 \ , 'do_mapping'      : 1
 \ })

" ================ Fugitive Config =================="{{{2
"
nnoremap <silent> ,dg :diffget<CR>
nnoremap <silent> ,dp :diffput<CR>

" let g:syntastic_enable_signs=1 " Mark syntax errors with :signs
" let g:syntastic_auto_jump=0 " Auto jump to the error when saving the file
" let g:syntastic_auto_loc_list=1 " Show the error list automatically
" let g:syntastic_quiet_messages={'level': 'warnings'} " Don't care about warnings
" let g:syntastic_enable_perl_checker=0 " Perl checker

if has('mac')
  call neomake#configure#automake('rw', 200)
endif

" ================ SASS Config ======================"{{{2
"
au BufRead,BufNewFile *.scss set filetype=scss.css

" Function names starting with a keyword (e.g. baseline-unit()) are not
" highlighted correctly by default.
autocmd FileType scss set iskeyword+=-


" ================ YouCompleteMe ===================="{{{2
"
" These settings prevent YCM from clashing with UltiSnips

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
" let g:ycm_server_python_interpreter="/usr/bin/python"

" YCM gives you popups and splits by default that some people might
" not like, so these should tidy it up a bit for you.

" let g:ycm_add_preview_to_completeopt=0
" let g:ycm_confirm_extra_conf=0
" set completeopt-=preview

" Useful keymapes to enable/disable
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR> " turn off YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR> " turn on YCM

" Go to definition shortcut
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Fixes error messages when typing in some filetypes
"" Do not display "Pattern not found" messages during YouCompleteMe completion
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
try
  set shortmess+=c
catch /E539: Illegal character/
endtry


" ================ dbext ============================"{{{2
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


" ################ START VIM SETTINGS ############### {{{1
"  _ _  _  _   _    __  ___  ___  ___  _  _  _  __  __
" | | || || \_/ |  / _|| __||_ _||_ _|| || \| |/ _|/ _|
" | V || || \_/ |  \_ \| _|  | |  | | | || \\ ( |_n\_ \
"  \_/ |_||_| |_|  |__/|___| |_|  |_| |_||_|\_|\__/|__/
"

" ================ Indenting Shortcuts =============="{{{2
"
" vnoremap > >gv " Keep selection when indending   # Use . instead to repeat
" indent


" ================ Tab shortcuts ===================="{{{2
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


" ================ Split window shortcuts ==========="{{{2
"
nnoremap <silent> vv <C-w>v " Split vert.
nnoremap <silent> ss <C-w>s " Split hori.

nnoremap <C-J> <C-W><C-J> " Instead of ctrl-w then j, it’s just ctrl-j:
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" ================ Indentation ======================"{{{2
"
set autoindent
set smartindent
set smarttab
set expandtab

set shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4 " foldmethod=indent







" ================ Set Sane Defaults ================"{{{2
"
let mapleader=","
" let &colorcolumn=join(range(81,999),",")

" line numbers
set number      " Numbers on left

" set relativenumber
nnoremap ,n :set relativenumber!<CR>
nnoremap ,rr <CR>

set ignorecase  " Ignore case
set smartcase

set laststatus=2
set autowriteall  " Save buffers when lose focus

" Don't break words when wrapping lines
set linebreak

" Make backspace on mac behave
set backspace=2

" use visual terminal bell
set vb

" make wrapped lines more obvious
" set wrap!
let &showbreak="↳ ↳ "
set cpoptions+=n " start soft-wrap lines (and any prefix) in the line-number area

" Make tabs, non-breaking spaces and trailing white space visible
set list
" Use a Musical Symbol Single Barline (0x1d100) to show a Tab, a Middle
" Dot (0x00B7) for trailing spaces, and the negation symbol (0x00AC) for
" non-breaking spaces
set listchars=tab:𝄀\ ,trail:·,extends:→,precedes:←,nbsp:¬

" Force *.tt files to load proper syntax
autocmd BufNewFile,BufRead *.tt setfiletype tt2html


" When wrap is off, horizontally scroll a decent amount.
set sidescroll=16

" Open file in last postion,runs the shortcut '"
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif



" Opens docstring window at bottom for jedi
set splitbelow

" Don't use Ex mode; use Q for console mode
map Q q:
set cmdwinheight=12 " larger console window

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024

" ================ Split Windows ===================="{{{2
"


set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE


" ================ Search ==========================="{{{2
"
set hlsearch
set incsearch
nnoremap // :nohlsearch<CR>

" Solarized default: hi CursorLine termbg=0 guibg=Grey40
hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue ctermfg=white




" ================ Persistent Undo =================="{{{2
"
call system('mkdir -p ~/.vim/backups/' )
call system('mkdir -p ~/.vim/undos/' )
call system('mkdir -p ~/.vim/swaps/' )

set undofile
set undodir=~/.vim/undos

set backup
set backupdir=~/.vim/backups

set directory=~/.vim/swaps


" ================ Font Settings ===================="{{{2
"
set encoding=utf8

set guifont=Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete:h15
set linespace=2

" ================ Modelines ========================"{{{2
"
set modeline
set modelines=5

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &foldmethod, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


" ================ emenu - experimental ============="{{{2
"

" YOU CAN MANUALLY TRIGGER MENU COMPLETION BY INVOKING TAB COMPLETION ON THE
" :EMENU COMMAND, BY DOING :EMENU<SPACE><TAB>

" Enable smart command line completion on <Tab> (enable listing all possible
" choices, and navigating the results with <Up>, <Down>, <Left>, <Right>, and
" <Enter>)
set wildmenu

" Make repeated presses cycle between all matching choices " better command line completion
	set wildmode=longest,full
	set fileignorecase
	set wildignorecase

	" Ingore backup files & git directories
	set wildignore+=*~,.git

" Load the default menus (this would happen automatically in gvim, but not in
" terminal vim)
" TODO: Replace with custom menu
source $VIMRUNTIME/menu.vim



" ================ Spelling Options ================="{{{2
"
set complete+=kspell " auto complete with C-X C-K
set spelllang=en_gb

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red ctermbg=white

nnoremap <Leader>. :setlocal spell! spelllang=en_us<CR>


" ================ Folds ============================"{{{2
"
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set foldmethod=marker


autocmd filetype python setlocal foldmethod=indent


hi Folded term=bold cterm=NONE ctermfg=lightblue " ctermbg=NONE
set fillchars+=fold:\·

nmap <space> za
nmap <leader><space> zR

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = '·'
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

" ################ REQURES TO BE AT END ############# {{{1
""         ___  _  _  __    _ _   _   ___ __
""        | __|| \| ||  \  | | | / \ | o Y _|
""        | _| | \\ || o ) | V || o ||   |_ \
""        |___||_|\_||__/   \_/ |_n_||_|\\__/
""

" ================ Better Vim Strokes ==============="{{{2
"
" unmap keys I shouldn't be using

" inoremap jk <esc>
" inoremap <esc> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
"
" ================ DEV ICON ========================="{{{2
"
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:WebDevIconsNerdTreeAfterGlyphPadding='  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign=1
augroup devicons
  autocmd!
  autocmd FileType nerdtree setlocal nolist
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree setlocal conceallevel=3
  autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" so ~/dotfiles/vim/plugins/color_devicons.vim
so ~/dotfiles/vim/plugins/color_devicons_alt.vim
so ~/dotfiles/vim/startify.vim

" Vim Color Debugging

" Identify the syntax highlighting group used at the cursor
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
nnoremap zz :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" ================ buffer shortcuts ================="{{{2
"

" Move to next buffer and delete current one
nnoremap <leader>q :bn<CR>:bd#<CR>


" Prevent preview windows from being on buffer list
" autocmd BufNew * if FileType qf | setlocal nobuflisted | endif
autocmd FileType qf setlocal nobuflisted

" If in particular window, just tab to main
"
autocmd FileType nerdtree  map <buffer> <Tab> <c-w>l " Tab out to main buffer - right
autocmd FileType tagbar  map <buffer> <Tab> <c-w>h " Tab out to main buffer - left
autocmd FileType qf  map <buffer> <Tab> <c-w>k " Tab out to main buffer - Up

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Encryption

set cm=blowfish2

" ================ Custom Colors ===================="{{{2
"                    __ _  _   _  ___ __
"                   / _/ \| | / \| o Y _|
"                  ( (( o ) |( o )   |_ \
"                   \__\_/|___\_/|_|\\__/
"


" See https://github.com/scrooloose/nerdtree/issues/201
" syntax match NERDTreeTxtFile #^\s\+.*txt$#
" highlight def link NERDTreeTxtFile error

" syntax match COMMCust #^" ==.*$#
" highlight def link COMMCust error


" ================ Additional Vim Commands =========="{{{2
"   __  _ _  __  ___ _  _   _    __  _   _  __
"  / _|| | |/ _||_ _/ \| \_/ |  / _|| \_/ ||  \
" ( (_ | U |\_ \ | ( o ) \_/ | ( (_ | \_/ || o )
"  \__||___||__/ |_|\_/|_| |_|  \__||_| |_||__/
"
command! -nargs=+ FigletEf :r!figlet -f eftifont <args>
command! -nargs=+ FigletSmall :r!figlet -f small <args>
command! -nargs=+ FigletDrPepper :r!figlet -f drpepper <args>
command! -nargs=+ Figlet :r!figlet <args>
command! -nargs=+ Gitlazy :!pwd;git add .;git commit -am '<args>';git push
command! -nargs=* ItermTitle silent execute '!echo -e "\033];<args>\007";export DISABLE_AUTO_TITLE="true"' | redraw!

command! Trim :%s/\s*$//g | nohlsearch | exe "normal! g'\""

command! Pyrun execute "!python %"
command! PyrunI execute "!python -i %"

" Run yapf when = is pressed to format python - https://github.com/mindriot101/vim-yapf
" You can yse `=` or `gq` to format python code using pep8
" autocmd filetype python setlocal equalprg=yapf formatprg=yapf
command! AutoPep8  execute "!yapf %"

command! Write :!sudo tee %


" Helpers for Simplerr
command! RunServer execute "term python manage.py runserver --site=website"

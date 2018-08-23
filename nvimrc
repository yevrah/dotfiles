" ################ INFORMATION ###################### {{{1
"
" Summary
" =======
"
" This neovim config aims to provide a function development environment, with
" a primary target of python. Other languages are also support and easily
" plugged in via necomplete, or language servers.
"
" Linking this dotfile
" ====================
"
" Make sure to link to this file before running neovim.
"
"   $ mkdir -p .config/nvim
"   $ ln -s $HOME/dotfiles/nvimrc $HOME/.config/nvim/init.vim
"
" Building Neovim on Redhat 6
" ===========================
"
" This process works for Neovim 0.32
"
"   # Requirements
"   $ sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
"   $ git clone https://github.com/neovim/neovim.git
"   $ make CMAKE_BUILD_TYPE=Release
"   $ sudo make install
"
" Install IUS Community Packages
" ==============================
" IUS is a community project that provides RPM packages for newer versions of
" select software for Enterprise Linux distributions.
"
"   $ curl 'https://setup.ius.io/' -o setup-ius.sh
"
" Additional, add the python bindings   - python2
"
"   $ sudo yum install epel-release                 # Extra Packages for Enterprise Linux)
"   $ sudo yum upgrade python-setuptools
"   $ sudo yum install python-pip python-wheel
"   $ pip install neovim
"
" Add python 3
"
"   $ sudo yum install python-devel
"   $ sudo yum install epel-release
"   $ sudo yum install python3 python3-wheel
"   $ pip install neovim
"
"


" ################ PRE-FLIGHT CHECKS ################ {{{1
"

let s:first_run=0

call system('mkdir -p ~/.config/nvim/backups/' )    " backups folder
call system('mkdir -p ~/.config/nvim/undos/' )      " undo folder
call system('mkdir -p ~/.config/nvim/swaps/' )      " swap files
call system('mkdir -p ~/.config/nvim/session/' )    " session files
call system('mkdir -p ~/.config/nvim/autoload/' )   " session files
call system('mkdir -p ~/.config/nvim/plugged/')     " plugin folder

" Install vim plug if not already
if !filereadable("~/.config/nvim/autoload/plug.vim")
    call system('curl -fLo ~/.config/nvim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')

    " ok, lets source this and flag the first run, we'll do a plugin install
    " afterwards
    let s:first_run=1
    so '~/.config/nvim/autoload/plug.vim'
endif



" ################ PLUG SECTION   ################### {{{1
"
call plug#begin('~/.config/nvim/plugged')

Plug 'haishanh/night-owl.vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'romainl/flattened'           " Actually a better solarized
Plug 'vim-scripts/wombat256.vim'
Plug 'vim-scripts/twilight256.vim'
Plug 'jacoborus/tender.vim'
Plug 'drewtempelmeyer/palenight.vim'

" General Improvements
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/YankRing.vim'
Plug 'junegunn/vim-easy-align'

" Nerd Tree Relate
Plug 'scrooloose/nerdtree'

" Code Completion
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'


" File search and find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Visual Improvements
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-voom/VOoM'

Plug 'bling/vim-bufferline'

" Initialize plugin system
call plug#end()

if s:first_run
    execute ':PlugInstall'
endif

" ################ START VIM SETTINGS ############### {{{1
"  _ _  _  _   _    __  ___  ___  ___  _  _  _  __  __
" | | || || \_/ |  / _|| __||_ _||_ _|| || \| |/ _|/ _|
" | V || || \_/ |  \_ \| _|  | |  | | | || \\ ( |_n\_ \
"  \_/ |_||_| |_|  |__/|___| |_|  |_| |_||_|\_|\__/|__/
"


" ================ sane defaults ===================="{{{2
"

filetype off                    " Do not fire file events
syntax enable                   " Enable syntax highlighting
let mapleader=','               " Remap leader
colorscheme afterglow

set nocompatible                " Disable compatibility to old-time vi
set termguicolors               " Allow colorschemes to set colors
set showmatch                   " Show matching brackets.
set smartcase
set ignorecase                  " Do case insensitive matching
set tabstop=4                   " number of columns occupied by a tab character
set softtabstop=4               " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4                " width for autoindents
set expandtab                   " converts tabs to white space
set smarttab
set autoindent                  " indent a new line the same amount as the line just typed
set smartindent
set number                      " add line numbers
set autowriteall                " Save buffers when lose focus
set linebreak                   " Dont break words when wrapping
set cmdwinheight=12             " larger console window
set splitbelow                  " Split predictably below
set splitright                  " Split redictably right

set undofile                    " Use undo files
set backup                      " Use backups
set undodir=~/.config/nvim/undos       " And set location
set backupdir=~/.config/nvim/backups   " keep backups at this dir
set directory=~/.config/nvim/swaps     " Keeo swapfiles here

set modeline                    " use modelines
set modelines=5                 " check 5 lines at begginning/end of file

set foldnestmax=3               " deepest fold is 3 levels
set nofoldenable                " dont fold by default
set foldmethod=marker           " use marker foldmethod
set fillchars+=fold:\·          " fill character for folds

set wildmenu                    " Command menu
set wildmode=longest,full       " Make repeated presses cycle between all matching choices 
set fileignorecase              " better command line completion
set wildignorecase              " better command line completion
set wildignore+=*~,.git         " Ingore backup files & git directories

set list                        " show unwanted whitespace characters, tab, etc
set listchars=tab:𝄀\ ,trail:·,
   \extends:→,precedes:←,nbsp:¬


" ================ sane simple keymappings =========="{{{2
"

" Aim to stay on home row
inoremap ;a <Esc>

nnoremap \\         :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nnoremap //         :nohlsearch<CR>
nnoremap <leader>f  :FZF<CR>
nnoremap <leader>p  :so %<CR>:PlugInstall<CR>
nnoremap <leader>yr :YRShow<CR>
nnoremap <leader>s  :set invspell<CR>

" Easy Align
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" Fold/Unfold using space
nnoremap <space> za
nnoremap <leader><space> zR

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" Buffer helpers, delete, tab to next, shift-tab to previous
nnoremap <leader>q :bn<CR>:bd#<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" ================ move lines and blocks ============"{{{2
"
" see https://dockyard.com/blog/2013/09/26/vim-moving-lines-aint-hard

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ================ tab shortcuts ===================="{{{2
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


" ================ split window shortcuts ==========="{{{2
"
nnoremap <silent> vv <C-w>v " Split vert.
nnoremap <silent> ss <C-w>s " Split hori.

" These clash with moving line blocks
" nnoremap <C-J> <C-W><C-J> " Instead of ctrl-w then j, it’s just ctrl-j:
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>



" ================ theme switching =================="{{{2
"
let g:favourite_themes = ['afterglow', 'night-owl', 'tir_black',
    \ 'flattened_dark', 'wombat256mod', 'twilight256', 'tender', 'palenight']

let g:current_theme  = -1

function! ChangeTheme(increment)
    let l:length = len(g:favourite_themes)
    let g:current_theme += a:increment

    if g:current_theme > l:length - 1
        let g:current_theme = 0
    endif

    if g:current_theme < 0
        let g:current_theme = l:length - 1
    endif

    let l:theme = g:favourite_themes[g:current_theme]
    execute 'colorscheme ' . l:theme
    " echo 'THEME CHANGED: ' . l:theme
endfunction


nnoremap <leader>cn :call ChangeTheme(1)<CR>
nnoremap <leader>cp :call ChangeTheme(-1)<CR>


" ================ startify setup ==================="{{{2
"

"let g:ctrlp_reuse_window  = 'startify' " Alow ctrlp to use startify window
let g:startify_session_dir='~/.config/nvim/session'
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
      \ { 'n': '~/dotfiles/nvimrc' },
      \ { 'z': '~/dotfiles/zshrc' },
      \ { 'p': '~/dotfiles/pythonrc.py' },
      \ ]


" ================ modelines ========================"{{{2
"

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



" ================ folds ============================"{{{2
"
hi Folded term=bold cterm=NONE ctermfg=lightblue " ctermbg=NONE

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


" ================ buffer interactions =============="{{{2
"

" Prevent preview windows from being on buffer list
" autocmd BufNew * if FileType qf | setlocal nobuflisted | endif
autocmd FileType qf setlocal nobuflisted

" If in particular window, just tab to main
autocmd FileType nerdtree  map <buffer> <Tab> <c-w>l " Tab out to main buffer - right
autocmd FileType tagbar  map <buffer> <Tab> <c-w>h " Tab out to main buffer - left
autocmd FileType qf  map <buffer> <Tab> <c-w>k " Tab out to main buffer - Up



" ================ ag - silver searcher ============="{{{2
"
" https://robots.thoughtbot.com/faster-grepping-in-vim

" The Silver Searcher, if available
"  1. bind to :grep syntax
"  2. create new :Ag syntax
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

" bind K to grep word under cursor - useful even if Ag not installed
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>



" ================ EXMPERIMENTAL ===================="{{{1
"



" ================ deoplete setup ==================="{{{2
"

" MORE CONFIG HERE: https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 3
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/NeoSnips'
let g:jedi#show_call_signatures = "2"

inoremap <expr><C-n>  deoplete#mappings#manual_complete()
autocmd FileType markdown
       \ call deoplete#custom#buffer_option('auto_complete', v:false)

" Src: https://computableverse.com/blog/my-terminal-setup<Paste>
" SuperTab like snippets' behavior.
" Map expression when a tab is hit:
"           checks if the completion popup is visible
"           if yes 
"               tab just exits out, use <C-n>, <C-p> as normal
"           else 
"               if expandable_or_jumpable
"                   then expands_or_jumps
"                   else returns a normal TAB

imap <expr><TAB>
 \ pumvisible() ? "\<CR><TAB>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Expands or completes the selected snippet/item in the popup menu
imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
      \ "\<Plug>(neosnippet_jump_or_expand)" : "\<CR>"

smap <silent><CR> <Plug>(neosnippet_jump_or_expand)










" Vim Color Debugging

" Identify the syntax highlighting group used at the cursor
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
nnoremap zz :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>




" ================ additional Vim Commands =========="{{{2
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

" vim: set ts=4 sw=4 tw=78 fdm=marker et :

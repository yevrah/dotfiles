 " ################ INFORMATION ###################### {{{1
"
" Summary
" =======
"
" This neovim config aims to provide a function development environment, with
" a primary target of python, node and html. Other languages are also support
" and easily plugged in via necomplete, or language servers.
"
" Linking this dotfile
" ====================
"
" Make sure to link to this file before running neovim.
"
"   $ mkdir -p .config/nvim
"   $ ln -s $HOME/dotfiles/nvimrc $HOME/.config/nvim/init.vim
"
" ################ PRE-FLIGHT CHECKS ################ {{{1
"
" we need these folders to exist
call system('mkdir -p ~/.config/nvim/backups/' )    " backups folder
call system('mkdir -p ~/.config/nvim/undos/' )      " undo folder
call system('mkdir -p ~/.config/nvim/swaps/' )      " swap files
call system('mkdir -p ~/.config/nvim/session/' )    " session files
call system('mkdir -p ~/.config/nvim/autoload/' )   " autoload folder
call system('mkdir -p ~/.config/nvim/plugged/')     " plugin folder


" figure out the system python for neovim - we assume that the neovim python
" server has been installed globally.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
    let g:python_host_prog=substitute(system("which -a python | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
    let g:python_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif


" Install vim plug if not already
if glob("~/.config/nvim/autoload/plug.vim") ==# ""
    echom "Install plug.vim, restart and run :PlugInstall"
    call system('curl -fLo ~/.config/nvim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif


" ################ PLUG SECTION   ################### {{{1
"
call plug#begin('~/.config/nvim/plugged')

Plug 'danilo-augusto/vim-afterglow'     " My preferred dark theme
Plug 'pbrisbin/vim-colors-off'          " Monochrome with both light and dark

" General Improvements
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/YankRing.vim'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'

" Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Tags autogeneration and management
Plug 'ludovicchabant/vim-gutentags'

" Git plugins
Plug 'tpope/vim-fugitive'

" Navigation related
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Visual Improvements
Plug 'pacha/vem-tabline'
Plug 'mhinz/vim-startify'


" Initialize plugin system
call plug#end()

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
colorscheme afterglow            " Use afterglow theme

set nocompatible                " Disable compatibility to old-time vi
set completeopt=menu            " Don't show preview pane on complete options
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
nnoremap \\         :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nnoremap //         :nohlsearch<CR>
nnoremap <leader>f  :FZF<CR>
nnoremap <leader>yr :YRShow<CR>
nnoremap <leader>s  :set invspell<CR>

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Delete comments '//## ...' comments, used normally when annotating files.
nnoremap <leader>cc :g/^\s*\/\/##/d<CR>

" Fold/Unfold using space
nnoremap <space> za
nnoremap <leader><space> zR

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" Buffer helpers, delete, tab to next, shift-tab to previous
function! ExitCurrent()
    " go to next buffer, delete alt (previous) buffer, and close window if
    " possible.
    execute 'silent! w!'
    execute 'silent! bn!'
    execute 'silent! bd!#'
    " execute 'silent! close!'
endfunction

nnoremap <leader>q        :call ExitCurrent()<CR>
nnoremap <silent><Tab>    :bnext<CR>
nnoremap <silent><S-Tab>  :bprevious<CR>

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
" in order Alt-J, Alt-K, Alt L, and Alt-H
nnoremap ∆ <C-W><C-J> " Alt-J - move to downward window split
nnoremap ˚ <C-W><C-K> " Alt-K - move up
nnoremap ¬ <C-W><C-L> " Alt-L - move right
nnoremap ˙ <C-W><C-H> " Alt-H - move left

" ================ indenting by file types =========="{{{2
"
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2

" ================ startify setup ==================="{{{2
"

"let g:ctrlp_reuse_window  = 'startify' " Alow ctrlp to use startify window
let g:startify_session_dir='~/.config/nvim/session'
let g:startify_session_persistence = 1 " Automatically save sessions one exit

let g:startify_list_order=[
    \ ['   My sessions:'],
    \ 'sessions',
    \
    \ ['   My most recently used files in the current directory:'],
    \ 'dir',
    \
    \ ['   My most recently used files'],
    \ 'files',
    \
    \ ['   My bookmarks:'],
    \ 'bookmarks',
    \
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

augroup startup_buffer
    autocmd!

    " Prevent preview windows from being on buffer list
    " autocmd BufNew * if FileType qf | setlocal nobuflisted | endif
    autocmd FileType qf setlocal nobuflisted

    " If in particular window, just tab to main
    autocmd FileType nerdtree  noremap <buffer> <Tab> <c-w>l " Tab out to main buffer - right
    autocmd FileType tagbar  noremap <buffer> <Tab> <c-w>h " Tab out to main buffer - left
    autocmd FileType qf  noremap <buffer> <Tab> <c-w>k " Tab out to main buffer - Up
augroup END


" ================ ag - silver searcher ============="{{{2
"

" bind K to grep word under cursor - useful even if Ag not installed
nnoremap K :Ag <C-R><C-W><CR>

" bind K to grep word under cursor - useful even if Ag not installed
noremap T :call fzf#vim#tags(expand('<cword>'))<CR>

" " find todos and fixmes
nnoremap <leader>t :Ag 'FIXME\|TODO'<CR>


" ================ status line ======================"{{{2
"
" https://gist.github.com/meskarune/57b613907ebd1df67eb7bdb83c6e6641

" status bar colors
augroup start_statusline
    autocmd!
    au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
    au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

    " Insired by https://github.com/bling/vim-bufferline/blob/master/autoload/bufferline.vim
    " autocmd BufWinEnter,WinEnter,InsertLeave,VimResized * echo ' ' . expand('%:p')

    " This depends on udpatetime value
    " autocmd CursorHold * echo ' ' . expand('%:p')
augroup END

" https://www.nkantar.com/blog/my-vim-statusline
function! PasteMode()
    if &paste == 1 | return "│ PASTE" | else
    return ""
endfunction

hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ nr2char(22): 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
set noshowmode
set statusline=
" set statusline+=%0*\ %n\                                 " Buffer number
" set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
" set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                             " FileType
set statusline+=│                                    " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''} " Encoding
set statusline+=\ │\                                 " Separator
set statusline+=%{&ff}                               " FileFormat (dos/unix..)
set statusline+=\ │\                                 " Separator
set statusline+=%{FugitiveHead()}                    " Git status
set statusline+=\ │\                                 " Separator
set statusline+=%{gutentags#statusline()}
set statusline+=\ │\                                 " Separator
set statusline+=\ %{expand('%:p')}                   " File Path
set statusline+=%=                                   " Right Side
set statusline+=%1*\ COL\ %02v\                      " Colomn number
set statusline+=%1*│                                 " Separator
set statusline+=%1*\ LINE\ %02l/%L\                  " Line number / total lines, percentage of document
set statusline+=%1*│                                 " Separator
set statusline+=%1*\ %3p%%\                          " Line number / total lines, percentage of document
set statusline+=%0*\ %{toupper(get(g:currentmode,mode(),char2nr(mode())))}\  " The current mode
set statusline+=%0*%{toupper(PasteMode())}\          " The current mode


" ################ EXMPERIMENTAL ####################"{{{1
"

" ================ deoplete setup ==================="{{{2
"
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/NeoSnips'
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
xmap <C-s> <Plug>(neosnippet_expand_target)

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"
" Markdown Helpers
"

" Create file under cursor
nnoremap <leader>gf :e <cfile><cr>
nnoremap <leader>gb :!open -a "Google Chrome" %

"
" Ale config
"

nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

" Sign column, custom text and always on
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_column_always = 1

" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
" let g:ale_sign_warning = '.'
"
" Ale linters and fixers, needs additionl support if you want to use - perform
" the following:
"
"   pip install black
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file


let g:ale_linters = {
            \     'javascript': ['eslint', 'tsserver'],
            \     'typescript': ['eslint', 'tsserver'],
            \     'python': ['flake8', 'mypy', 'pyls']
            \ }

" Fix files automatically on save
let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \    '*': ['remove_trailing_lines', 'trim_whitespace'],
            \    'javascript': ['eslint'],
            \    'typescript': ['eslint', 'tsserver'],
            \    'python': ['black'],
            \    'css': ['prettier']
            \ }

" ================ additional Vim Commands =========="{{{2
"   __  _ _  __  ___ _  _   _    __  _   _  __
"  / _|| | |/ _||_ _/ \| \_/ |  / _|| \_/ ||  \
" ( (_ | U |\_ \ | ( o ) \_/ | ( (_ | \_/ || o )
"  \__||___||__/ |_|\_/|_| |_|  \__||_| |_||__/
"
:
command! -nargs=+ FigletSmall       :r!figlet -f drpepper <args>
command! -nargs=+ Figlet            :r!figlet <args>

command! -nargs=+ Gitlazy :!pwd;git add -A;git commit -am '<args>';git pull;git push

command! -nargs=* Title execute 'set titlestring=<args>' | execute 'set title'
command! Trim :%s/\s*$//g | nohlsearch | exe "normal! g'\""

command! Pyrun execute "!python %"
command! PyrunI execute "!python -i %"
command! AutoPep8  execute "!yapf %"

command! Write :!sudo tee %

command! Mono :colorscheme off | set background=light
command! KillAll :bufdo bd


" Find Replace Helper
nnoremap <leader>fr :!find . -type f \| xargs perl -pi -e 's/<C-R><C-W>/newwordhere/g'

" vim: set ts=4 sw=4 tw=78 fdm=marker et :

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

call plug#begin('~/.config/nvim/plugged')

Plug 'danilo-augusto/vim-afterglow'     " My preferred dark theme
Plug 'pbrisbin/vim-colors-off'          " Monochrome with both light and dark

" General Improvements
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/YankRing.vim'
""" Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'

" Markdown experimens
" Plug 'masukomi/vim-markdown-folding'
" Plug 'SidOfc/mkdx'
" Plug 'gabrielelana/vim-markdown'
" Plug 'godlygeek/tabular'
" Plug 'preservim/vim-markdown'

" Snippets
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'

" Tags autogeneration and management
" Plug 'preservim/tagbar'
" Plug 'ludovicchabant/vim-gutentags'

" Git plugins
Plug 'tpope/vim-fugitive'

" Navigation related
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Visual Improvements
Plug 'pacha/vem-tabline'
Plug 'mhinz/vim-startify'

" Install individual language servers with
"   :CocInstall coc-json coc-tsserver
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" " Language Server!
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
"     \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"     \ 'python': ['/usr/local/bin/pyls'],
"     \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
"     \ }

" " note that if you are using Plug mapping you should not use `noremap` mappings.
" nmap <F5> <Plug>(lcn-menu)
" " Or map each action separately
" nmap <silent>K <Plug>(lcn-hover)
" nmap <silent> gd <Plug>(lcn-definition)
" nmap <silent> <F2> <Plug>(lcn-rename)





" PHP Stuff
""" Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}

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
""" set backup                      " Use backups
""" set undodir=~/.config/nvim/undos       " And set location
""" set backupdir=~/.config/nvim/backups   " keep backups at this dir

""" Settings for CoC - see docs https://github.com/neoclide/coc.nvim
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

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
nnoremap <space> zA
nnoremap <leader><space> zR

" No nested folding on markdown
" autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

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
      \ { 'v': '~/Documents/dotfiles/vimrc' },
      \ { 'n': '~/Documents/dotfiles/nvimrc' },
      \ { 'z': '~/Documents/dotfiles/zshrc' },
      \ { 'p': '~/Documents/dotfiles/pythonrc.py' },
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


" Simplified Markdown Folds - no need for complex plugins
" Thanks to
" - https://gist.github.com/sjl/1038710
" - https://stackoverflow.com/questions/3828606/vim-markdown-folding
" - https://www.markdownguide.org/basic-syntax/

function! MarkdownLevel()
    " Headings using '#' symbols
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif

    " Headings Using == and --
    if getline(v:lnum+1) =~ '^==\+\s*'
        return ">1"
    endif
    if getline(v:lnum+1) =~ '^--\+\s*'
        return ">2"
    endif


    return "="
endfunction
au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr


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
" set statusline+=%{gutentags#statusline()}
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


" ================ coc nvim setup ==================="{{{2
"
"

" 'coc-git',
" 'coc-angular',
" 'coc-cmake',
" 'coc-docker',
" 'coc-explorer',
" 'coc-fzf-preview',
" 'coc-html'
" 'coc-lightbulb',
" 'coc-phpactor',
" 'coc-prisma',
" 'coc-pydocstring',
" 'coc-snippets',
let g:coc_global_extensions = [
            \   'coc-json',
            \   'coc-html',
            \   'coc-css',
            \   'coc-prettier',
            \   'coc-pyright',
            \   'coc-sh',
            \   'coc-tsserver',
            \   'coc-eslint',
            \   'coc-pairs',
            \   'coc-phpls',
            \   'coc-phpactor']



" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Command Palette
command! -nargs=0 CC :CocCommand

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 CCPrettier :CocCommand prettier.formatFile

command! -nargs=0 Snippets :CocCommand snippets.editSnippets
command! -nargs=0 CCSnippets :CocCommand snippets.editSnippets

command! -nargs=0 Diagnostics :Diagnostics
command! -nargs=0 CCDiagnostics :Diagnostics

command! -nargs=0 CCRename :call CocActionAsync('rename')
command! -nargs=0 CCRefactor :call CocActionAsync('refactor')

command! -nargs=0 CCGoDefinition :call CocActionAsync('jumpDefinition')
command! -nargs=0 CCGoImplementation :call CocActionAsync('jumpImplementation')
command! -nargs=0 CCGoReferences :call CocActionAsync('jumpReferences')
command! -nargs=0 CCGoDoc :call CocActionAsync('doHover')

command! -nargs=0 CCDoFormat :call CocActionAsync('formatSelected')
command! -nargs=0 CCDoFormatAll :call CocActionAsync('format')
command! -nargs=0 CCDoOrganiseImports :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! -nargs=0 CCDoHideSuggestions :let b:coc_suggest_disable = 1<CR>

""" Should use the below for the above
"""
""      function! ShowDocumentation()
""        if CocAction('hasProvider', 'hover')
""          call CocActionAsync('doHover')
""        else
""          call feedkeys('K', 'in')
""        endif
""      endfunction


" Tab commpletions
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Disable autocomplete suggestions
let b:coc_suggest_disable = 1

" gd to go to definition
nmap <silent> gd <Plug>(coc-definition)
" gr to go to reference
nmap <silent> gr <Plug>(coc-references)

" Minor color tweak for type hints
" hi CocInlayHint guibg=Red guifg=Blue ctermbg=Red ctermfg=Blue
hi CocInlayHint guifg=Gray ctermfg=Gray

" ################ EXPERIMENTAL ####################"{{{1
"

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/Users/harvey/Documents/dotfiles/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }


"
" Markdown Helpers
"

" Create file under cursor
nnoremap <leader>gf :e <cfile><cr>
nnoremap <leader>gb :!open -a "Google Chrome" %

"
" Ale config
"
""" SWITCHED OFF TO TEST Coc
""" nmap <silent> [c <Plug>(ale_previous_wrap)
""" nmap <silent> ]c <Plug>(ale_next_wrap)
"""
""" " Sign column, custom text and always on
""" highlight clear ALEErrorSign
""" highlight clear ALEWarningSign
""" let g:ale_sign_error = '❌'
""" let g:ale_sign_warning = '⚠️'
""" let g:ale_sign_column_always = 1
"""
""" " let g:ale_sign_error = '●' " Less aggressive than the default '>>'
""" " let g:ale_sign_warning = '.'
""" "
""" " Ale linters and fixers, needs additionl support if you want to use - perform
""" " the following:
""" "
""" "   pip install black
""" let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
"""
""" " PHP Ale setup
""" " --------------
""" " php gives us basic syntax checking. langserver provides completion and
""" " go-to-definition functionality. phan checks types and warns for undefined
""" " symbols.
"""
""" let g:ale_linters = {
"""             \     'javascript': ['eslint', 'tsserver'],
"""             \     'typescript': ['eslint', 'tsserver'],
"""             \     'python': ['flake8', 'mypy', 'pyls'],
"""             \     'php': ['php', 'phpactor', 'phan']
"""             \ }
"""
""" " Fix files automatically on save
""" let g:ale_fix_on_save = 1
""" let g:ale_fixers = {
"""             \    '*': ['remove_trailing_lines', 'trim_whitespace'],
"""             \    'javascript': ['eslint'],
"""             \    'typescript': ['eslint', 'tsserver'],
"""             \    'python': ['black'],
"""             \    'css': ['prettier']
"""             \ }


" Debug colorscheme
" Showing highlight groups
" This function will show what groups are being applied. Add to your ~/.vimrc,
" place your cursor over the item in question, and press <leader>sz to output
" the groups.
"
" @see https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes
nmap <leader>sz :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

hi Conceal ctermfg=7 ctermbg=242 guifg=black guibg=DarkGrey
" vim: set ts=4 sw=4 tw=78 fdm=marker et :

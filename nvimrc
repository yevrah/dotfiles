" ################ INFORMATION ###################### {{{1
"
" Summary
" =======
"
" This neovim config aims to provide a function development environment, with
" a primary target of python. Other languages are also support and easily
" plugged in via necomplete, or language servers.
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
" Additional, add the python bindings
"
"   $ sudo yum install epel-release
"   $ yum install python-pip
"   $ pip install neovim
"
" Installing Vim-Plug
" ===================
"
" Simply run the following command
"
"   $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"   $   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

" ################ PRE-FLIGHT CHECKS ################ {{{1
"
call system('mkdir -p ~/.nvim/backups/' )   " Backups folder
call system('mkdir -p ~/.nvim/undos/' )     " Undo folder
call system('mkdir -p ~/.nvim/swaps/' )     " Swap files
call system('mkdir -p ~/.nvim/session/' )   " Session files
call system('mkdir -p ~/.config/nvim/autoload/' )   " Session files
call system('mkdir -p ~/.config/nvim/plugged/')      " Plugin folder

" Install vim plug
if !filereadable("~/.config/nvim/autoload/plug.vim")
    call system('curl -fLo ~/.config/nvim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

" https://www.circuidipity.com/neovim/
" https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html


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
Plug 'vim-voom/VOoM'

Plug 'bling/vim-bufferline'

" Initialize plugin system
call plug#end()


" ################ START VIM SETTINGS ############### {{{1
"  _ _  _  _   _    __  ___  ___  ___  _  _  _  __  __
" | | || || \_/ |  / _|| __||_ _||_ _|| || \| |/ _|/ _|
" | V || || \_/ |  \_ \| _|  | |  | | | || \\ ( |_n\_ \
"  \_/ |_||_| |_|  |__/|___| |_|  |_| |_||_|\_|\__/|__/
"


" ================ Sane Defaults ===================="{{{2
"
filetype off                    " Do not fire file events
syntax enable
let mapleader=','               " Remap leader

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
set undodir=~/.nvim/undos       " And set location
set backupdir=~/.nvim/backups   " keep backups at this dir
set directory=~/.nvim/swaps     " Keeo swapfiles here

" set cryptmethod=blowfish2     " Set stronger default encryption

"set hlsearch               " highlight search results
"set wildmode=longest,list  " get bash-like tab completions



" ================ Hidden Characters ================"{{{2
"

" Make tabs, non-breaking spaces and trailing white space visible
set list
" Use a Musical Symbol Single Barline (0x1d100) to show a Tab, a Middle
" Dot (0x00B7) for trailing spaces, and the negation symbol (0x00AC) for
" non-breaking spaces
set listchars=tab:𝄀\ ,trail:·,extends:→,precedes:←,nbsp:¬

" ================ Sane Simple Keymappings =========="{{{2
"

" Aim to stay on home row
inoremap ;a <Esc>


nnoremap \\ :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nnoremap // :nohlsearch<CR>
nnoremap <leader>f  :FZF<CR>
nnoremap <leader>p  :so %<CR>:PlugInstall<CR>
nnoremap <leader>yr :YRShow<CR>

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" ================ move lines and blocks ============"{{{2
"
" see https://dockyard.com/blog/2013/09/26/vim-moving-lines-aint-hard

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

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


" ================ split window shortcuts ==========="{{{2
"
nnoremap <silent> vv <C-w>v " Split vert.
nnoremap <silent> ss <C-w>s " Split hori.

" These clash with moving line blocks
" nnoremap <C-J> <C-W><C-J> " Instead of ctrl-w then j, it’s just ctrl-j:
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>


" color scheme: tir_black
colorscheme afterglow

nmap <leader>c1 :colorscheme afterglow<CR>
nmap <leader>c2 :colorscheme night-owl<CR>
nmap <leader>c3 :colorscheme tir_black<CR>
nmap <leader>c4 :colorscheme flattened_dark<CR>
nmap <leader>c5 :colorscheme wombat256mod<CR>
nmap <leader>c6 :colorscheme twilight256<CR>
nmap <leader>c7 :colorscheme tender<CR>
nmap <leader>c8 :colorscheme palenight<CR>


" ================ startify setpshortcuts ==========="{{{2
"

"let g:ctrlp_reuse_window  = 'startify' " Alow ctrlp to use startify window
let g:startify_session_dir='~/.nvim/session'
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



" ================ folds ============================"{{{2
"
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set foldmethod=marker
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
" source $VIMRUNTIME/menu.vim


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


" ================ EXMPERIMENTAL ===================="{{{2
"

"
" EXPLERIMENTAL
"


" toggle spelling
nnoremap <leader>s :set invspell<CR>



" bind K to grep word under cursor
nnoremap F :FZF<CR>


"
" USE AG: The silver searcher
"

" https://robots.thoughtbot.com/faster-grepping-in-vim

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

let g:jedi#show_call_signatures = "2"




" ================ deoplete setup ==================="{{{2
"

" MORE CONFIG HERE: https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 3

autocmd FileType markdown
       \ call deoplete#custom#buffer_option('auto_complete', v:false)

" Src: https://computableverse.com/blog/my-terminal-setup<Paste>
" SuperTab like snippets' behavior.
" Map expression when a tab is hit:
"           checks if the completion popup is visible
"           if yes 
"               then it cycles to next item
"           else 
"               if expandable_or_jumpable
"                   then expands_or_jumps
"                   else returns a normal TAB

imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
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

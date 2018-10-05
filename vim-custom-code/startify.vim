let g:sol = {
      \"gui": {
      \"base03": "#002b36",
      \"base02": "#073642",
      \"base01": "#586e75",
      \"base00": "#657b83",
      \"base0": "#839496",
      \"base1": "#93a1a1",
      \"base2": "#eee8d5",
      \"base3": "#fdf6e3",
      \"yellow": "#b58900",
      \"orange": "#cb4b16",
      \"red": "#dc322f",
      \"magenta": "#d33682",
      \"violet": "#6c71c4",
      \"blue": "#268bd2",
      \"cyan": "#2aa198",
      \"green": "#719e07"
      \},
      \"cterm": {
      \"base03": 8,
      \"base02": 0,
      \"base01": 10,
      \"base00": 11,
      \"base0": 12,
      \"base1": 14,
      \"base2": 7,
      \"base3": 15,
      \"yellow": 3,
      \"orange": 9,
      \"red": 1,
      \"magenta": 5,
      \"violet": 13,
      \"blue": 4,
      \"cyan": 6,
      \"green": 2
      \}
      \}
augroup startify
  autocmd!
  " No need to show spelling ‘errors’
  autocmd FileType startify setlocal nospell
  " Better header colour
  exec 'autocmd FileType startify if &background == ''dark'' | '.
        \ 'highlight StartifyHeader guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
        \ 'else | '.
        \ 'highlight StartifyHeader guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
        \ 'endif'
  " Better section colour
  exec 'autocmd FileType startify highlight StartifySection guifg='.g:sol.gui.blue.' ctermfg='.g:sol.cterm.blue
  " Better file colour
  exec 'autocmd FileType startify if &background == ''dark'' | '.
        \ 'highlight StartifyFile guifg='.g:sol.gui.base0.' ctermfg='.g:sol.cterm.base0.' | '.
        \ 'else | '.
        \ 'highlight StartifyFile guifg='.g:sol.gui.base00.' ctermfg='.g:sol.cterm.base00.' | '.
        \ 'endif'
  " Better special colour
  " exec 'autocmd FileType startify highlight StartifySpecial gui=italic cterm=italic guifg='.g:sol.gui.yellow.' ctermfg='.g:sol.cterm.yellow
  " Hide those ugly brackets
  " exec 'autocmd FileType startify if &background == ''dark'' | '.
  "       \ 'highlight StartifyBracket guifg='.g:sol.gui.base03.' ctermfg='.g:sol.cterm.base03.' | '.
  "       \ 'else | '.
  "       \ 'highlight StartifyBracket guifg='.g:sol.gui.base3.' ctermfg='.g:sol.cterm.base3.' | '.
  "       \ 'endif'
augroup END

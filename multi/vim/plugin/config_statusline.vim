let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=0
let g:airline_symbols_ascii = 1

" I don't actively use eclim
let g:airline#extensions#eclim#enabled = 0
" Don't add CursorMoved events
let g:airline#extensions#wordcount#enabled = 0

" Only enable these locally since I don't want to see them for files written
" by other people.
let g:airline#extensions#whitespace#checks = []

" In increasing order of me liking them.
let g:airline_theme='luna'
let g:airline_theme='wombat'
let g:airline_theme='bubblegum'
" Instead of sanity (which was a copy of bubblegum), just patch bubblegum.
"~ let g:airline_theme='sanity'

let g:airline_theme_patch_func = 'AirlineThemeSanity'
function! AirlineThemeSanity(palette)
    if g:airline_theme == 'bubblegum'
        let a:palette.accents = get(a:palette, 'accents', {})
        let a:palette.accents.red = [ '#ff8300' , '' , 160 , ''  ]
    endif
endfunction

"let g:airline_mode_map = {
"    \ '__' : '-',
"    \ 'n'  : 'N',
"    \ 'i'  : 'I',
"    \ 'R'  : 'R',
"    \ 'c'  : 'C',
"    \ 'v'  : 'V',
"    \ 'V'  : 'V',
"    \ '' : 'V',
"    \ 's'  : 'S',
"    \ 'S'  : 'S',
"    \ '' : 'S',
"    \ }

if executable('svn')
    let g:airline#extensions#branch#custom_head = 'david#svn#get_branch'
endif


" Show jobs in airline next to fileencoding.
let g:airline_section_y = "%{david#init#asyncrun_status()}%{airline#util#wrap(airline#parts#ffenc(),0)}"


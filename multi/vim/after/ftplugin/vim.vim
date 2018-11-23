" Filetype set fo+=o, but I tend to use o and O to add whitespace, not
" to continue comments
setlocal formatoptions-=o

" My vim syntax doesn't have folding, so use indent.
if &foldmethod != 'diff'
    setlocal foldmethod=indent
endif

" Easy source file.
if exists(':Runtime') == 2
    " Use scriptease's Runtime to auto-disarm load guards.
    nnoremap <buffer> <Leader>vso :update<CR>:Runtime %<CR>
else
    nnoremap <buffer> <Leader>vso :update<CR>:source %<CR>
endif

" Easy execute line.
" https://stackoverflow.com/a/20262740/79125
command! -buffer -bar -range Eval silent <line1>,<line2>yank c | let @c = substitute(@c, '\n\s*\\', '', 'g') | @c
nnoremap <buffer> <Leader>v: :<C-u>Eval<CR>
" ; is easier than :
nnoremap <buffer> <Leader>v; :<C-u>Eval<CR>
" Source selection
xnoremap <buffer> <Leader>v; :Eval<CR>

" Easy echo.
nnoremap <buffer> <Leader>ve 0y$:echo <C-r>"<CR>
xnoremap <buffer> <Leader>ve y:execute 'echo '. @"<CR>

" In vimscript, use compl-vim instead of omnicomplete for smart completion.
inoremap <buffer> <C-Space> <C-x><C-v>

" No tabs in vim files.
setlocal expandtab

" Jump to file that may have defined this symbol. A bit weird because it's not
" looking at filenames (vim doesn't have includes), but it's not a tag: we're
" guessing based on filename like normal gf behaviour.
nnoremap <buffer> gf :<C-u>call david#vim#GotoFile(expand("<cword>"))<CR>

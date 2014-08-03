
" Use :make to compile c, even without a makefile
" This is problematic with deep directories (and I don't understand glob)
"if glob('Makefile') == "" | let &mp="g++ -o %< %" | endif
setlocal cindent

" surround key o - Unoptimize region
let b:surround_111 = "#pragma optimize( \"\", off ) \r #pragma optimize( \"\", on )"

" surround key i - Wrap region in if block
let b:surround_105 = "if (\1if condition: \1)\n{ \r }"

" surround key d - ifdef region
let b:surround_100 = "#ifdef \1ifdef condition: \1 \r #endif"

" Ensure the above are indented. This reindents everything within the surround
" (is that undesirable?). I don't think there's a way to only indent what we
" inserted.
let b:surround_indent = 1

if exists('loaded_cpp_extra') || &cp
    finish
endif
let loaded_cpp_extra = 1

" Filetype set fo+=o, but I tend to use o and O to add whitespace, not
" to continue comments
setlocal formatoptions-=o

" To prevent extra indents to ctor initializations, I want cino=i0. Not sure
" how to only change that option, so I've modified ~/.vim/indent/cpp.vim

runtime cscope_maps.vim

" macros
iabbrev #i #include
iabbrev #d #define

" Header comments (requires formatoptions+=r)
"  Creates a header with the filename, foldername, author, description, and
" copyright. Cursor is left on description and other fields are autogenerated
" (using abbrevs or guessed based on file).
" Different from generic version because it uses // instead of /**/
"nmap <Leader>hc ggO//<CR> @file	<C-r>%<CR>@ingroup	<C-r>=expand('%:p:h:t')<CR><CR><CR>@author	_me<CR>@brief	<CR><CR>Copyright (c) <C-R>=strftime("%Y")<CR> _company All Rights Reserved.<CR><Esc>3kA



" Fast switch between header and implementation (instead of lookup file)
"
" Source: http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file#By_modifying_ftplugins
function <SID>SwitchSourceHeader()
    try
        if (expand("%:t") == expand("%:t:r") . ".h")
            try
                find %:t:r.cpp
            catch /^Vim\%((\a\+)\)\=:E345/
                " Error: Can't find file. Try inline instead.
                find %:t:r.inl
            endtry
        else
            find %:t:r.h
        endif
    catch /^Vim\%((\a\+)\)\=:E345/
        " If we can't find it in the path, see if it's in ctrlp.
        if exists("*CtrlPSameName")
            call CtrlPSameName()
        endif
    endtry
endfunction

nnoremap <silent> <A-o> :call <SID>SwitchSourceHeader()<CR>

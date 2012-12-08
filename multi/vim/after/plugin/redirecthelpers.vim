" Grab vim message text
"
" Automates use of the :redir command by putting the output into a new buffer.
" Author: pydave
"
" Dependencies: Uses itchy plugin for REnd
"

if !exists('itchy_loaded') || exists(':Scratch') != 2
    echoerr 'RedirectHelpers requires itchy'
    finish
elseif exists('g:loaded_redirecthelpers')
    finish
endif
let g:loaded_redirecthelpers = 1

"" Puts the last g search command in a new buffer
function! <SID>What()
	let s:c_save = @c
    redir @c
    global/
    redir END
    silent Scratch redirect
    put! c
	let @c = s:c_save
endfunction
command! What call <SID>What()

"" Puts whatever is in between RStart and REnd in a new buffer
"" You can use ctag/cscope output, g searches, whatever!
function! <SID>RedirectStart()
	let s:c_save = @c
	let s:more_save = &more
	set nomore
	redir @c
endfunction
command! RStart call <SID>RedirectStart()
function! <SID>RedirectEnd()
    redir END
    silent Scratch redirect
    put! c
	let @c = s:c_save
	let &more = s:more_save
endfunction
command! REnd call <SID>RedirectEnd()

"" Faster ways to start search redirects. Require REnd once complete.
cabbrev rg redir @c<CR>:g
cabbrev rv redir @c<CR>:v
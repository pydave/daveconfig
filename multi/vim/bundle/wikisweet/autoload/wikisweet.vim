" Build the name of the function for formatting links for this filetype.
function! s:filetype_to_format_function(filetype)
	return 'wikisweet#'. a:filetype .'#FormatLinkForFiletype'
endfunction

" Convert a url to the input filetype. 
function! wikisweet#UrlToWikiLink(desired_filetype)
    let c_backup = @c

    normal! "cyiW
    let url = @c
    let name = wikisweet#UrlToName(url)
    let format_function = s:filetype_to_format_function(a:desired_filetype)
    try
        exec 'let @c = '. format_function .'(name, url)'
    catch /^Vim\%((\a\+)\)\=:E117/	" E117: Unknown function
        if &verbose > 0
            echoerr 'Input filetype '. a:desired_filetype .' has no format function. Define '. format_function .'. See :help autoload for more.'
        endif
		let format_function = s:filetype_to_format_function('markdown')
        exec 'let @c = '. format_function .'(name, url)'
    endtry
    normal! viW"cp

    let @c = c_backup
endf

" Convert a url to a human-readable name.
"
" Essentially truncates to the page name and converts some characters to
" spaces.
function! wikisweet#UrlToName(url)
    let c_backup = @c
    let lazy_backup = &lazyredraw

    Scratch
    0put =a:url
    ConvertFromUrlEncoding
    normal! "cdiW
    bdelete
	let name = @c
	let name = substitute(name, '^.*/', '', '')
	let name = substitute(name, '+', ' ', 'g')
	let name = substitute(name, '-', ' ', 'g')

    let &lazyredraw = lazy_backup
    let @c = c_backup
    return name
endf

" Submodules don't put the COMMIT_EDITMSG directly in .git/. Instead it's in
" the submodule's folder under .git/, hence this autocmd.
"
" $VIMRUNTIME/filetype.vim should be updated with this change.
" Using this autocmd breaks fugitive when committing from submodules:
" https://github.com/tpope/vim-fugitive/issues/474
"autocmd BufNewFile,BufRead */.git/**/COMMIT_EDITMSG setf gitcommit

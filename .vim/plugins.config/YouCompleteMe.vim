" Always use an extra ycm conf file from home.
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" Don't prompt when using the extra ycm conf.
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_insertion=1

" Go to definition/include fast (<c-]> doesn't work with all layouts).
noremap <silent> <c-k> :YcmCompleter GoToImprecise<cr>
noremap <silent> <c-t> :YcmCompleter GetType<cr>

" Less commonly used mappings.
noremap <silent> <leader>gt :YcmCompleter GoTo<cr>
noremap <silent> <leader>gp :YcmCompleter GetParent<cr>
noremap <silent> <leader>gi :YcmCompleter GoToInclude<cr>
noremap <silent> <leader>gr :YcmCompleter GoToReferences<cr>
noremap <silent> <leader>gd :YcmCompleter GetDoc<cr>

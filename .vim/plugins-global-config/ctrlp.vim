" Use the silver searcher where available.
if executable('ag')
    let g:ctrlp_user_command='ag --path-to-ignore ~/.ignore %s --ignore-case --nocolor --nogroup --hidden -g ""'
endif

let g:ctrlp_max_files=10000
" Always use the current working directory rather than the location of the
" current file.
let g:ctrlp_working_path_mode='ra'
" Most of the time it is enough to search by filename.
let g:ctrlp_by_filename=1

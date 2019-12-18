" Disable default mappings
let g:EasyMotion_do_mapping=0

" Turn on case insensitive feature
let g:EasyMotion_smartcase=1

" Use all default keys except for f (compatbility with Firefox's VimFX).
let g:EasyMotion_keys='asdghklqwertyuiopzxcvbnmj;'

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap <cr> <plug>(easymotion-overwin-f2)
" Fix <cr> in places where it is needed.
" TODO some plugin windows use 'o[pen]' as a shortcut, so consider keeping
" easy-motion functionality in these windows, by using 'o' instead.
autocmd BufReadPost quickfix noremap <buffer> <cr> <cr>
autocmd BufReadPost location noremap <buffer> <cr> <cr>
autocmd CmdWinEnter * noremap <buffer> <cr> <cr>

" Line motions
map <leader>h <plug>(easymotion-linebackward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>l <plug>(easymotion-lineforward)

" Disable default mappings
let g:EasyMotion_do_mapping=0

" Turn on case insensitive feature
let g:EasyMotion_smartcase=1

" Use all default keys except for f (compatbility with Firefox's VimFX).
let g:EasyMotion_keys='asdghklqwertyuiopzxcvbnmj;'

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap <cr> <plug>(easymotion-overwin-f2)

" Line motions
map <leader>h <plug>(easymotion-linebackward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>l <plug>(easymotion-lineforward)

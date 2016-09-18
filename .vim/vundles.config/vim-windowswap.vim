" Prevent default bindings
let g:windowswap_map_keys=0

" Alt+m to window swap, so that it works from nvim terminal
noremap <silent> <a-m> :call WindowSwap#EasyWindowSwap()<cr>
if has('nvim')
    tnoremap <silent> <a-m> <c-\><c-n>:call WindowSwap#EasyWindowSwap()<cr>
endif

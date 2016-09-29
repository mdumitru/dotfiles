" Open NERDTree by default if vim is started with no files.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Close a tab if NERDTree is the only remaining window.
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTreeType')
                    \ && b:NERDTreeType == 'primary') |
                    \ q |
                    \ endif


let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1


noremap <silent> <leader>nn :NERDTreeFocus<cr>
noremap <silent> <leader>nt :NERDTreeToggle<cr>
noremap          <leader>nb :NERDTreeFromBookmark<space>
noremap <silent> <leader>nf :NERDTreeFind<cr>

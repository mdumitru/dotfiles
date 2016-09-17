let g:bufExplorerDefaultHelp = 0
let g:bufExplorerFindActive=0
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = 'name'

" Alt+e opens buf explorer, so that it works from nvim terminal
noremap <a-e> :ToggleBufExplorer<cr>
if has('nvim')
    tnoremap <a-e> <c-\><c-n>:ToggleBufExplorer<cr>
endif

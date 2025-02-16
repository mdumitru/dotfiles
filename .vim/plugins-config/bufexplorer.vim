" Don't display help at the top
let g:bufExplorerDefaultHelp=0
" Always open the buffer in the bufexplorer window
let g:bufExplorerFindActive=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowNoName=1


" Alt+e opens buf explorer, so that it works from nvim terminal
noremap <silent> <a-e> :ToggleBufExplorer<cr>
if has('nvim')
    tnoremap <silent> <a-e> <c-\><c-n>:ToggleBufExplorer<cr>
endif

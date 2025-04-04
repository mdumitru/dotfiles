" Source 'common' vimrc
let s:vimcommon_path=expand($HOME . "/.vimcommon")
if filereadable(s:vimcommon_path)
    exe 'source' s:vimcommon_path
endif

let g:terminal_scrollback_buffer_size=100000  " legacy
set scrollback=100000

" Normal escape in terminal. Ctrl+Alt+e to send an Escape through.
tnoremap <esc> <c-\><c-n>
tnoremap <c-a-e> <esc>

function! s:UpdateMode()
    if &buftype ==# 'terminal'
        startinsert
    else
        " Only leave insert mode if we are currently in insert mode
        if mode() ==# 'i'
            stopinsert
        endif
    endif
endfunction

command! Tsplit split | terminal
command! Tvsplit vsplit | terminal
command! Ttabedit tabedit | terminal
noremap <a-t> :Ttabedit<cr>
tnoremap <a-t> <c-\><c-n>:Ttabedit<cr>
tnoremap <a-n> <c-\><c-n>:tabedit<cr>
tnoremap <silent> <f1> <c-\><c-n>:nohlsearch<cr>gi

" The BufEnter event is triggered, no need to return to insert explicitly.
tnoremap <silent> <f4> <c-\><c-n>:ToggleTabLineNumbers<cr>

" Better navigation
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
tnoremap <a-i> <c-\><c-n>gT
tnoremap <a-o> <c-\><c-n>gt
tnoremap <silent> <c-a-i> <c-\><c-n>:execute "tabmove" tabpagenr() - 2<cr>
tnoremap <silent> <c-a-o> <c-\><c-n>:execute "tabmove" tabpagenr() + 1<cr>

let s:luainit=stdpath('config') . '/lua/init.lua'
if filereadable(s:luainit)
    exe 'source' s:luainit
endif

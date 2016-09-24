set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar


if has("gui_win32")
    set guifont=Hack:h12:cDEFAULT   " font options
    set linespace=2                 " pixels between lines

    noremap <silent> <f11> <esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>

    " Start maximized.
    autocmd GUIEnter * simalt ~x
else
    set guifont=DejaVu\ Sans\ Mono\ 11  " font options
    set linespace=-1                    " pixels between lines

    noremap <silent> <f11> <esc>:call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<cr>

    " Start maximized.
    autocmd GUIEnter * call system("wmctrl -i -b add,maximized_vert,maximized_horz -r " . v:windowid)
endif

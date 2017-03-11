" Source 'before' file (if any).
let vimbefore_path=expand($HOME . "/.gvimrc.before")
if filereadable(vimbefore_path)
    exe 'source' plugins_path
endif


set guicursor=a:block-Cursor    " set curosor to always be a block
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove right-hand scroll bar
set guioptions-=L  " remove left-hand scroll bar


if has("gui_win32")
    set guifont=Hack:h14:cDEFAULT   " font options
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


" Source 'after' file (if any).
let vimafter_path=expand($HOME . "/.gvimrc.after")
if filereadable(vimafter_path)
    exe 'source' plugins_path
endif

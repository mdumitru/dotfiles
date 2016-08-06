set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar


if has("gui_win32")
    set guifont=Hack:h12:cDEFAULT
    set linespace=2
else
    set guifont=DejaVu\ Sans\ Mono\ 11
    set linespace=-1
endif

if has("gui_win32")
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>	
else
    map <F11> <Esc>:call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR><Esc>
endif


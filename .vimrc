let s:vimcommon_path=expand($HOME . "/.vimcommon")
if filereadable(s:vimcommon_path)
    exe 'source' s:vimcommon_path
endif

" Load all plugins.
let s:plugins_path=expand($HOME . "/.vim/plugins.vim")
if filereadable(s:plugins_path)
    exe 'source' s:plugins_path
endif


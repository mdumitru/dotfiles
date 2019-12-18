" Use the silver searcher where available.
if executable('ag')
    let g:ackprg='ag --path-to-ignore ~/.ignore --vimgrep'
endif

" Alias all Ack commands to Ag equivalents. The Ag plugin is deprecated, keep
" these for compatibility.
for cmd in ['Ack', 'AckAdd', 'AckFromSearch', 'LAck', 'LAckAdd', 'AckFile', 'AckHelp', 'LAckHelp', 'AckWindow', 'LAckWindow']
    exe 'command! ' . substitute(cmd, 'Ack', 'Ag', '') . ' ' . cmd
endfor

" Recursively search a string in all subdirectories.
command! -nargs=+ S :Ag! '<args>'

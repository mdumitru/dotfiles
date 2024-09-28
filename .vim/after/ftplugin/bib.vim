setlocal smarttab
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal textwidth=80
setlocal colorcolumn=81

let s:plugins_dir = expand($HOME . "/.vim/plugins-local-config/")
exe 'source ' s:plugins_dir . "coc.nvim"
exe 'source ' s:plugins_dir . "coc-texlab.nvim"

setlocal autoindent
setlocal cindent
setlocal smarttab
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal textwidth=80
setlocal colorcolumn=81

let plugins_dir = expand($HOME . "/.vim/plugins-local-config/")
exe 'source ' plugins_dir . "coc.nvim"
exe 'source ' plugins_dir . "vim-better-whitespace"
exe 'source ' plugins_dir . "tagbar"

" Python specific settings
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal colorcolumn=80
setlocal expandtab
setlocal autoindent
setlocal cindent
setlocal fileformat=unix

let plugins_dir = expand($HOME . "/.vim/plugins-local-config/")
exe 'source ' plugins_dir . "vim-better-whitespace"
exe 'source ' plugins_dir . "tagbar"

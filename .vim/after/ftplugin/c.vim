" Inspired by the Linux kernel coding style.
setlocal autoindent
setlocal cindent
setlocal smarttab
setlocal noexpandtab
setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8

setlocal textwidth=80
setlocal colorcolumn=81

let plugins_dir = expand($HOME . "/.vim/plugins-local-config/")
exe 'source ' plugins_dir . "vim-better-whitespace"
exe 'source ' plugins_dir . "tagbar"

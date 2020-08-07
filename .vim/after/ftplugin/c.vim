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

let s:plugins_dir = expand($HOME . "/.vim/plugins-local-config/")
exe 'source ' s:plugins_dir . "coc.nvim"
exe 'source ' s:plugins_dir . "vim-better-whitespace"

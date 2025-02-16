-- Source the normal vimrc
local vimrc = vim.fn.expand("$HOME/.vimrc")
if vim.fn.filereadable(vimrc) == 1 then
  vim.cmd("source " .. vimrc)
end

require("config.lazy")
require("lazy").setup("plugins")

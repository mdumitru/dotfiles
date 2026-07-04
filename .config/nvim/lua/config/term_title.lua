-- Forward the host terminal's title so tools running inside a :terminal
-- (claude, codex, ...) propagate their OSC title changes outward, just like
-- they do when run directly in the terminal.
--
-- Neovim stores the title an embedded program sets (via OSC 0/1/2) in
-- b:term_title. With 'title' on, Neovim sets the host terminal title from
-- 'titlestring'; we forward b:term_title there, falling back to a sensible
-- name in non-terminal buffers.

local M = {}

function M.titlestring()
  local term_title = vim.b.term_title
  if term_title and term_title ~= "" then
    return term_title
  end

  local name = vim.fn.expand("%:t")
  return (name ~= "" and name or "[No Name]") .. " - nvim"
end

vim.o.title = true
vim.o.titlestring = '%{v:lua.require("config.term_title").titlestring()}'

return M

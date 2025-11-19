local function rename_terminal(bufnr, cwd)
  if vim.bo[bufnr].buftype == "terminal" then
    local pid = vim.fn.getpid()
    local name = string.format("term:%d:%s", pid, cwd)
    vim.api.nvim_buf_set_name(bufnr, name)
  end
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function(event)
    local cwd = vim.fn.getcwd()
    rename_terminal(event.buf, cwd)
    vim.bo[event.buf].filetype = "terminal"
  end,
})

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local cwd = vim.fn.getcwd()
    local bufnr = vim.api.nvim_get_current_buf()
    rename_terminal(bufnr, cwd)
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "DiagnosticChanged" }, {
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})

vim.keymap.set("n", "<c-l>", "<cmd>lopen<CR>", { desc = "Open location list" })

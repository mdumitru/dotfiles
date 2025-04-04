-- The goal is to always end up in insert mode when landing in a terminal and
-- always be out of insert mode when landing in other buffers.
-- Unfortunately, weird stuff happens sometimes: for example when using
-- telescope's buffer search and selecting a terminal, after the WinEnter and
-- BufEnter events, some mysterious InsertLeave is triggered messing any normal
-- scheme up.
-- So we just wait a very short while (it should be imperceptible for the user)
-- before returning to insert mode forcefully.
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "TermOpen" }, {
    callback = function()
        vim.defer_fn(function()
            if vim.bo.buftype == "terminal" and vim.fn.mode() ~= "i" then
                vim.cmd("startinsert")
            end
        end, 20)  -- Delay 20ms to bypass clean-up events.
    end,
})


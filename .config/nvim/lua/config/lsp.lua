local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local icons = require("config.icons")

local on_attach = function(_, bufnr)
    local buf_map = function(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    buf_map('n', 'gd', vim.lsp.buf.definition, { desc = 'go to definition' })
    buf_map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'go to type definition' })
    buf_map("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded", })
    end, { desc = 'Hover documentation' })
    buf_map('n', 'gi', vim.lsp.buf.implementation, { desc = 'go to implementation' })
    buf_map('n', 'gr', vim.lsp.buf.references, { desc = 'list references' })
    buf_map("n", "<C-l>", vim.lsp.buf.signature_help)
    buf_map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    buf_map("n", "[g", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
    buf_map("n", "]g", vim.diagnostic.goto_next, { desc = "next diagnostic" })
    buf_map({ "o", "x" }, "=", function()
        vim.lsp.buf.format({ async = true })
    end, { desc = "Format buffer with LSP" })

    vim.keymap.set("n", "<leader>rn", function()
        local curr_name = vim.fn.expand("<cword>")
        vim.ui.input({
            prompt = "New Name: ",
            default = curr_name,
        }, function(input)
            if input and #input > 0 and input ~= curr_name then
                vim.lsp.buf.rename(input)
            end
        end)
    end, { desc = "LSP Rename (floating input)" })
end


vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        },
    },
})

vim.api.nvim_create_user_command("OR", function()
    local ft = vim.bo.filetype
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })

    for _, client in ipairs(clients) do
        if client.name == "pyright" and ft == "python" then
            vim.cmd("PyrightOrganizeImports")
            return
        elseif client.name == "tsserver" and (ft == "typescript" or ft == "javascript") then
            -- tsserver organize imports
            local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = ""
            }
            client.request("workspace/executeCommand", params, nil, 0)
            return
        elseif client.name == "lua_ls" and ft == "lua" then
            vim.notify("No organize imports command for Lua", vim.log.levels.INFO)
            return
        end
    end

    vim.notify("No supported LSP client for organize imports", vim.log.levels.WARN)
end, { desc = "Organize imports for the current filetype" })

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

local servers = {
    'lua_ls',
    'clangd',
    'pyright',
    'ts_ls',
    'html',
    'cssls',
    'bashls',
    'texlab',
    'vimls',
    'jsonls',
}

for _, server in ipairs(servers) do
    local opts = {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    local ok, server_opts = pcall(require, 'config.lsp.' .. server)
    if ok then
        opts = vim.tbl_deep_extend('force', opts, server_opts)
    end

    lspconfig[server].setup(opts)
end

return {
    on_attach = on_attach,
    capabilities = capabilities,
}

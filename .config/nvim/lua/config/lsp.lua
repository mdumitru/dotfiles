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
    buf_map("n", "<space>rn", vim.lsp.buf.rename, { desc = "rename identifier" })
    buf_map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    buf_map("n", "[g", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
    buf_map("n", "]g", vim.diagnostic.goto_next, { desc = "next diagnostic" })
    buf_map({ "o", "x" }, "=", function()
        vim.lsp.buf.format({ async = true })
    end, { desc = "Format buffer with LSP" })
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

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
}

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

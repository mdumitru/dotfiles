local null_ls = require("null-ls")

return {
    setup = function(on_attach)
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.black,
            },
            on_attach = on_attach,
        })
    end,
}

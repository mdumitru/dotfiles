return {
    -- Chat with GitHub Copilot in Neovim
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
        },
    },

    -- Fully featured & enhanced replacement for copilot.vim complete with 
    -- API for interacting with Github Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<c-e>",
                        next = "<c-n>",
                        prev = "<c-p>",
                        dismiss = "<c-]>",
                    },
                },
                panel = { enabled = false },
            })
        end,
    }
}

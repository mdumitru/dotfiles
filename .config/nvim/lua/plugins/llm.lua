local prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
}

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        opts = {
            file_types = { "copilot-chat" },
        },
        ft = { "copilot-chat" },
    },

    -- Chat with GitHub Copilot in Neovim
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
            { "nvim-lua/plenary.nvim" },
            { "MeanderingProgrammer/render-markdown.nvim" },
        },
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            prompts = prompts,
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<c-x>",
                    insert = "<c-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<cr>",
                    insert = "<c-cr>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<c-y>",
                    insert = "<c-y>",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)

            local select = require("CopilotChat.select")
            vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
                chat.ask(args.args, { selection = select.visual })
            end, { nargs = "*", range = true })

            -- Inline chat with Copilot
            vim.api.nvim_create_user_command("CopilotChatInline", function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = "float",
                        relative = "cursor",
                        width = 1,
                        height = 0.4,
                        row = 1,
                    },
                })
            end, { nargs = "*", range = true })

            -- Restore CopilotChatBuffer
            vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
                chat.ask(args.args, { selection = select.buffer })
            end, { nargs = "*", range = true })

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
                    local ft = vim.bo.filetype
                    if ft == "copilot-chat" then
                        vim.bo.filetype = "markdown"
                    end
                end,
            })
        end,
        event = "VeryLazy",
        keys = {
            -- Code related commands
            { "<leader>ax", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
            { "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
            { "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
            { "<leader>aw", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
            { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
            { "<leader>af", "<cmd>CopilotChatFixError<cr>", desc = "CopilotChat - Fix Diagnostic" },
            {
                "<leader>av",
                ":CopilotChatInline ",
                mode = "x",
                desc = "CopilotChat - Inline chat",
            },
            -- Custom input for CopilotChat
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
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

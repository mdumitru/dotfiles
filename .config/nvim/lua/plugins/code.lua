return {
    -- ✅ Highlight, list and search todo comments in your projects
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- Completion engine
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require 'cmp'
            local icons = require 'config.icons'
            local copilot_suggestion = require 'copilot.suggestion'
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<tab>'] = cmp.mapping.select_next_item(),
                    ['<s-tab>'] = cmp.mapping.select_prev_item(),

                    -- FIXME This should be somewhere else
                    ['<c-e>'] = function(fallback)
                        if copilot_suggestion.is_visible() then
                            copilot_suggestion.accept()
                        else
                            fallback()
                        end
                    end,
                }),
                formatting = {
                    format = function(entry, vim_item)
                        local kind_icons = icons.kind
                        vim_item.kind = (kind_icons[vim_item.kind] or '') .. vim_item.kind
                        return vim_item
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                })
            }
        end
    },

    -- Quickstart configs for Nvim LSP
    "neovim/nvim-lspconfig",

    -- 🧠 💪 // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },

    -- Nvim Treesitter (main branch — new install/highlight API)
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            -- Idempotent: already-installed parsers are skipped.
            require('nvim-treesitter').install {
                "lua",
                "c",
                "cpp",
                "python",
                "javascript",
                "tsx",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "bash",
                "latex",
                "vim",
                "json",
            }

            -- The main branch has no `highlight`/`indent` options; enable them
            -- per-buffer for any filetype that has an installed parser.
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    if pcall(vim.treesitter.start) then
                        vim.bo[args.buf].indentexpr =
                            "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },

    -- textobjects powered selection / navigation (main branch)
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('nvim-treesitter-textobjects').setup {
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@function.outer'] = 'V',
                        ['@function.inner'] = 'V',
                        ['@class.outer'] = 'V',
                        ['@class.inner'] = 'V',
                    },
                },
                move = {
                    set_jumps = true,
                },
            }

            local select = require('nvim-treesitter-textobjects.select')
            local swap = require('nvim-treesitter-textobjects.swap')
            local move = require('nvim-treesitter-textobjects.move')

            -- select textobjects
            local selections = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['aa'] = '@parameter.outer', -- mnemonic pArameter
                ['ia'] = '@parameter.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
            }
            for lhs, obj in pairs(selections) do
                vim.keymap.set({ 'x', 'o' }, lhs, function()
                    select.select_textobject(obj, 'textobjects')
                end, { desc = 'Select ' .. obj })
            end

            -- swap textobjects
            vim.keymap.set('n', 'mo', function()
                swap.swap_next('@parameter.inner')
            end, { desc = 'Swap next parameter' })
            vim.keymap.set('n', 'mi', function()
                swap.swap_previous('@parameter.inner')
            end, { desc = 'Swap previous parameter' })

            -- move to textobjects (pairs of [, ])
            vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
                move.goto_next_start('@function.outer', 'textobjects')
            end, { desc = 'Next function start' })
            vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
                move.goto_previous_start('@function.outer', 'textobjects')
            end, { desc = 'Previous function start' })
            vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
                move.goto_next_end('@function.outer', 'textobjects')
            end, { desc = 'Next function end' })
            vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
                move.goto_previous_end('@function.outer', 'textobjects')
            end, { desc = 'Previous function end' })

            -- lsp_interop / peek_definition_code was removed in the
            -- main-branch rewrite; use native LSP as the closest equivalent.
            vim.keymap.set('n', '<c-k>', vim.lsp.buf.hover,
                { desc = 'Hover docs' })
            vim.keymap.set('n', '<c-c>', vim.lsp.buf.definition,
                { desc = 'Go to definition' })
        end,
    },

    -- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP
    -- diagnostics, code actions, and more via Lua.
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local none_ls = require("config.none-ls")
            none_ls.setup(require("config.lsp").on_attach)
        end,
    },

    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and
    -- formatters.
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        config = true,
    },

    -- Extension to mason.nvim that makes it easier to use lspconfig with
    -- mason.nvim.
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = { "lua_ls", "pyright", "ts_ls" },
            }
        end
    },
}

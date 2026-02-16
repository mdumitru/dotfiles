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

    -- Nvim Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            -- Update treesitter parsers
            vim.cmd(':TSUpdate')

            -- Try to install tree-sitter CLI globally if it's missing
            local handle = io.popen("which tree-sitter")
            local result = handle:read("*a")
            handle:close()

            if result == "" then
                vim.notify("Installing tree-sitter CLI globally via npm...", vim.log.levels.INFO)
                os.execute("npm install -g tree-sitter-cli")
            end
        end,
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
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
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true
                },
            }
        end
    },

    -- textobjects powered selection / navigation
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        opts = {
            textobjects = {

                -- select textobjects
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['aa'] = '@parameter.outer', -- mnemonic Term
                        ['ia'] = '@parameter.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['al'] = '@loop.outer',
                        ['il'] = '@loop.inner',
                    },
                    selection_modes = {
                        ['@function.outer'] = 'V',
                        ['@function.inner'] = 'V',
                        ['@class.outer'] = 'V',
                        ['@class.inner'] = 'V',
                    },
                },

                -- swap textobjects
                swap = {
                    enable = true,
                    swap_next = {
                        ['mo'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['mi'] = '@parameter.inner',
                    },
                },

                -- move to textobjects (pairs of [, ])
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']f'] = '@function.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                    },
                },

                -- lsp interoperability
                lsp_interop = {
                    enable = true,
                    border = 'rounded',
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ['<c-k>'] = '@function.outer',
                        ['<c-c>'] = '@class.outer', -- mnemonic See Class
                    },
                },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
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

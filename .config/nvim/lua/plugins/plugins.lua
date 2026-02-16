return {
    -- Recommended (for coloured icons) (by bufferline)
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- A snazzy bufferline for Neovim 
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup {
                options = {
                    mode = "tabs", -- Use tabs instead of buffers
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    show_tab_indicators = true,
                    separator_style = "thin",
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = true,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            text_align = "left"
                        }
                    }
                }
            }
        end,
    },

    --  Neovim's answer to the mouse 🦘
    {
        url = "https://codeberg.org/andyg/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        lazy = false,

        -- init runs before plugin is loaded; use for basic keybindings
        init = function()
            vim.keymap.set('n', '<c-m>', '<Plug>(leap-anywhere)')
            vim.keymap.set('x', '<c-m>', '<Plug>(leap)')
            vim.keymap.set('o', '<c-m>', '<Plug>(leap-forward)')
        end,

        -- config runs after plugin is loaded; safe to call functions here
        config = function()
            local leap = require('leap')

            -- Helper to jump to line starts in a given direction
            local function leap_to_lines(direction)
                local targets = {}
                local current_line = vim.fn.line('.')
                local total_lines = vim.fn.line('$')
                local start_line = direction == 'down' and current_line + 1 or current_line - 1
                local end_line = direction == 'down' and total_lines or 1
                local step = direction == 'down' and 1 or -1

                for line = start_line, end_line, step do
                    local line_content = vim.fn.getline(line)
                    local first_non_blank = vim.fn.match(line_content, [[\S]]) + 1 -- 1-indexed col
                    if first_non_blank > 0 then
                        table.insert(targets, {
                            pos = { line, first_non_blank },
                        })
                    end
                end

                if #targets == 0 then return end

                require('leap').leap {
                    target_windows = { vim.fn.win_getid() },
                    targets = targets,
                }

            end

            -- Helper to jump to word starts in the current line
            local function leap_to_words_in_line(direction)
                local targets = {}
                local line = vim.fn.line('.')
                local line_content = vim.fn.getline(line)
                local cursor_col = vim.fn.col('.')

                for start_col in line_content:gmatch('()(%f[%w])') do
                    if (direction == 'forward' and start_col > cursor_col) or
                       (direction == 'backward' and start_col < cursor_col) then
                        table.insert(targets, {
                            pos = { line, start_col }
                        })
                    end
                end

                if #targets == 0 then return end

                -- Reverse targets if going backward so leap prioritizes closest match
                if direction == 'backward' then
                    vim.fn.reverse(targets)
                end

                leap.leap {
                    target_windows = { vim.fn.win_getid() },
                    targets = targets,
                }
            end

            -- Set your custom motions
            vim.keymap.set({'n', 'x', 'o'}, '<leader>j', function() leap_to_lines('down') end)
            vim.keymap.set({'n', 'x', 'o'}, '<leader>k', function() leap_to_lines('up') end)
            vim.keymap.set({'n', 'x', 'o'}, '<leader>l', function() leap_to_words_in_line('forward') end)
            vim.keymap.set({'n', 'x', 'o'}, '<leader>h', function() leap_to_words_in_line('backward') end)
            require('leap').opts.labels = 'abcdefghijklmnopqrstuvwxyz'
            require('leap').opts.safe_labels = {}
            require('leap').opts.max_phase_one_targets = 25
        end,
    },


    -- A modern Vim and neovim filetype plugin for LaTeX files.
    {
        "lervag/vimtex",
        init = function()
            vim.g.tex_flavor = "latex"
        end,
    },

    -- Delete buffers and close files in Vim without messing up your layout.
    {
        "moll/vim-bbye",
        cmd = "Bdelete",
    },

    -- Find, Filter, Preview, Pick. All lua, all the time.
    {
        "nvim-telescope/telescope.nvim", tag = '0.1.8',
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { 'VeryLazy' },
        opts = {
            defaults = {
                cache_picker = {
                    num_pickers = 100,
                    limit_entries = 1000,
                },
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set({'n', 't'}, '<a-e>', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.command_history, { desc = "Telescope command history" })
            vim.keymap.set('n', '<leader>fs', builtin.search_history, { desc = "Telescope search history" })
            vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = "Telescope registers" })
            vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = "Telescope quickfix" })
            vim.keymap.set('n', '<leader>ft', builtin.man_pages, { desc = "Telescope man pages" })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Telescope diagnostics" })
        end,
    },

    -- Rename a buffer within Vim and on disk
    {
        "vim-scripts/Rename",
        cmd = "Rename",
    },

    -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
    "rebelot/kanagawa.nvim",

    -- Pasting in Vim with indentation adjusted to destination context
    "sickill/vim-pasta",

    -- Neovim file explorer: edit your filesystem like a buffer
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },

    -- a Git wrapper so awesome, it should be illegal
    "tpope/vim-fugitive",

    -- repeat.vim: enable repeating supported plugin maps with "."
    "tpope/vim-repeat",

    -- surround.vim: quoting/parenthesizing made simple
    "tpope/vim-surround",

    -- unimpaired.vim: pairs of handy bracket mappings
    "tpope/vim-unimpaired",

    -- Swap your windows without ruining your layout
    "wesQ3/vim-windowswap",
}

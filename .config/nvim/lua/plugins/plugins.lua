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
        dependencies = "nvim-tree/nvim-web-devicons"
    },

    "easymotion/vim-easymotion",

    -- BufExplorer Plugin for Vim
    {
        "jlanzarotta/bufexplorer",
        cmd = "ToggleBufExplorer",
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

    -- Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
    {
        "neoclide/coc.nvim",
        branch = "release",
    },

    -- Rename a buffer within Vim and on disk
    {
        "vim-scripts/Rename",
        cmd = "Rename",
    },

    -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
    "rebelot/kanagawa.nvim",

    -- A small automated session manager for Neovim
    {
        "rmagatti/auto-session",
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        }
    },

    -- Pasting in Vim with indentation adjusted to destination context
    "sickill/vim-pasta",

    -- Vim plugin for intensely orgasmic commenting
    "scrooloose/nerdcommenter",

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

    -- A vim plugin for toggling the display of the quickfix list and the location-list.
    "Valloric/ListToggle",

    -- Vim plugin that provides additional text objects
    "wellle/targets.vim",

    -- Swap your windows without ruining your layout
    "wesQ3/vim-windowswap",
}

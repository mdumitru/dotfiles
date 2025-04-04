local function setup_leap_highlights()
    local kanagawa = require("kanagawa.colors").setup()
    local palette = kanagawa.palette

    vim.api.nvim_set_hl(0, 'LeapLabelPrimary',   { fg = palette.samuraiRed, bold = true, underline = true })
    vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = palette.sakuraPink, italic = true })
    vim.api.nvim_set_hl(0, 'LeapMatch',          { fg = palette.springGreen, bold = true })
    vim.api.nvim_set_hl(0, 'LeapBackdrop',       { fg = palette.sumiInk6 })
end

-- Set up autocommand
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "kanagawa",
    callback = setup_leap_highlights,
})

-- If colorscheme is already active, apply highlights immediately
if vim.g.colors_name == "kanagawa" then
    setup_leap_highlights()
end

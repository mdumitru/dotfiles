-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "kanagawa" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})

local settings = vim.fn.expand(vim.env.HOME .. "/.vim/plugins-config/")
for _, fpath in ipairs(vim.fn.split(vim.fn.globpath(settings, '*'), "\n")) do
  vim.cmd("source " .. fpath)
end

-- Load local plugin settings, if any
local local_settings = vim.fn.expand(vim.env.HOME .. "/.vim/local-plugins-config/")
for _, fpath in ipairs(vim.fn.split(vim.fn.globpath(local_settings, '*'), "\n")) do
  vim.cmd("source " .. fpath)
end

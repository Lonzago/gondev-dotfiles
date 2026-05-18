-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- Disable native vim completion - we use blink.cmp instead
vim.opt.completeopt = { "menu", "menuone", "noselect" }

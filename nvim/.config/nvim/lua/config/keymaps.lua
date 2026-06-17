-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })

-- Manual completion trigger for blink.cmp
vim.keymap.set("i", "<C-CR>", function()
  require("blink.cmp").show()
end, { noremap = true, desc = "Manual completion (Ctrl+Enter)" })

vim.keymap.set("i", "<M-Space>", function()
  require("blink.cmp").show()
end, { noremap = true, desc = "Manual completion (Alt+Space)" })

vim.keymap.set("n", "<C-q>", "<cmd>qa<cr>", { noremap = true, silent = true, desc = "Quit Neovim" })
vim.keymap.set("i", "<C-q>", "<Esc><cmd>qa<cr>", { noremap = true, silent = true, desc = "Quit Neovim" })

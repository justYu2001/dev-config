-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>")

-- Go to next error
vim.keymap.set("n", "zn", vim.diagnostic.goto_next)

-- Go to previous error
vim.keymap.set("n", "zk", vim.diagnostic.goto_prev)

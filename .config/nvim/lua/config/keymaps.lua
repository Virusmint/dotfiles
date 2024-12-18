-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Sane window resizing
map("n", "<Left>", "<CMD>vertical resize +2<CR>", { noremap = true, silent = true })
map("n", "<Right>", "<CMD>vertical resize -2<CR>", { noremap = true, silent = true })
map("n", "<Up>", "<CMD>resize +2<CR>", { noremap = true, silent = true })
map("n", "<Down>", "<CMD>resize -2<CR>", { noremap = true, silent = true })

-- Redo change
map("n", "U", "<C-r>", { noremap = true, silent = true, desc = "Redo" })

-- Jump forward fix
map("n", "<C-I>", "<C-I>", { noremap = true })

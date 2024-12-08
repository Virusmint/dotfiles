-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Window movements
map("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = " window left" })
map("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = " move right" })
map("n", "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = " move down" })
map("n", "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = " move up" })

-- map("n", "<leader>wv", ":vsp<CR>", { noremap = true, silent = true, desc = "Split Window Right" })
-- map("n", "<leader>ws", ":sp<CR>", { noremap = true, silent = true, desc = "Split Window Below" })
-- map("n", "<leader>wD", ":only<CR>", { noremap = true, silent = true, desc = "Close All Windows" })
-- map("n", "<leader>w=", "<C-w>=", { noremap = true, silent = true, desc = "Resize Windows" })

-- Sane window resizing
map("n", "<Left>", "<CMD>vertical resize +2<CR>", { noremap = true, silent = true })
map("n", "<Right>", "<CMD>vertical resize -2<CR>", { noremap = true, silent = true })
map("n", "<Up>", "<CMD>resize +2<CR>", { noremap = true, silent = true })
map("n", "<Down>", "<CMD>resize -2<CR>", { noremap = true, silent = true })

-- Redo change
map("n", "U", "<C-r>", { desc = "Redo" })

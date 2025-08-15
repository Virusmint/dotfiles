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

-- TODO: fix this in a cleaner way? idk
-- Jump forward fix
map("n", "<C-I>", "<C-I>", { noremap = true })

-- Fix spelling mistakes
map("i", "<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "Correct last spelling error" })

-- Luasnip Choice Node
map("i", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false })
map("s", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false })
map("i", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false })
map("s", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false })

-- TODO: add which-key group for reloading files
-- Reload Luasnip snippets
map("n", "<leader>rs", function()
  require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets/" } })
  vim.notify("󰑓 LuaSnip snippets reloaded!", vim.log.levels.INFO)
end, { noremap = true, desc = "󰑓 Reload LuaSnip" })

-- Floating terminal
-- map("n", "<leader>tt", function()
--   require("lazyvim.util").float_term({ cmd = { "zsh" }, cwd = vim.fn.expand("%:p:h") })
-- end, { noremap = true, desc = "󰈞 Open floating terminal" })

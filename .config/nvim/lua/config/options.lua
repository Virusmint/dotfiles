vim.g.ai_cmp = false -- Disable Copilot cmp
vim.g.vimtex_quickfix_enabled = 0 -- Disable quickfix window for vimtex

local system = vim.fn.system("uname")
system = system:gsub("%s+", "")
if system == "Darwin" then
  vim.g.vimtex_view_method = "skim"
elseif system == "Linux" then
  vim.g.vimtex_view_method = "zathura"
end

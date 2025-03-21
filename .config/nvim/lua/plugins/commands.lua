local M = {}

-- Toggle Copilot inline suggestions
local copilot_enabled = true
vim.api.nvim_create_user_command("ToggleCopilotSuggestion", function()
  if copilot_enabled then
    vim.cmd("Copilot disable") -- Disable Copilot
    copilot_enabled = false
    vim.notify(" Copilot Disabled", vim.log.levels.INFO)
  else
    vim.cmd("Copilot enable") -- Enable Copilot
    copilot_enabled = true
    vim.notify(" Copilot Enabled", vim.log.levels.INFO)
  end
end, {})

vim.api.nvim_create_user_command("RnwVimtexCompile", function()
  vim.cmd("w")
  local basename = vim.fn.expand("%:r")
  vim.cmd("e " .. basename .. ".tex")
  vim.cmd("VimtexCompile")
  vim.cmd("bd")
  vim.cmd("e " .. basename .. ".Rnw")
end, {})

vim.api.nvim_create_user_command("RnwVimtexView", function()
  vim.cmd("w")
  local basename = vim.fn.expand("%:r")
  vim.cmd("e " .. basename .. ".tex")
  vim.cmd("VimtexView")
  vim.cmd("bd")
  vim.cmd("e " .. basename .. ".Rnw")
end, {})

return M

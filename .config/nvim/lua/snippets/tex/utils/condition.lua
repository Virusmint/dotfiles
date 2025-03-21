local M = {}

M.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
M.in_text = function()
  return not M.in_mathzone()
end
M.in_comment = function()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local function in_env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

M.in_preamble = function()
  return not in_env("document")
end

M.in_itemize = function() -- itemize environment detection
  return in_env("itemize")
end
M.in_tikz = function() -- TikZ picture environment detection
  return in_env("tikzpicture")
end

return M

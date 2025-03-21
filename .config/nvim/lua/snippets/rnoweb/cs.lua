local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
-- LaTeX conditional expansions functions with VimTeX
local tex = {}
tex.in_mathzone = function() -- math context detection
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1 or tex.in_env("equation") or tex.in_env("align*")
end
tex.in_text = function()
  return not tex.in_mathzone()
end
tex.in_comment = function() -- comment detection
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
tex.in_itemize = function() -- itemize environment detection
  return tex.in_env("itemize")
end
tex.in_tikz = function() -- TikZ picture environment detection
  return tex.in_env("tikzpicture")
end

return {
  -- TODO: bigO notation
  s(
    { trig = "OO", snippetType = "autosnippet", dscr = "big O" },
    fmta("\\bigO(<>)", {
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- TODO: Algorithm Blocks
  -- s(
  --   { trig = "BALG", snippetType = "autosnippet", dscr = "big O" },
  --   fmta("\\bigO(<>)", {
  --     i(1),
  --   }),
  --   { condition = tex.in_mathzone }
  -- ),
  -- TODO: Pseudocode definition
}

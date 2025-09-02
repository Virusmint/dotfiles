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

local function bash(_, _, command)
  local file = io.popen(command, "r")
  local result = {}
  -- check nil
  if file == nil then
    return result
  end
  for line in file:lines() do
    table.insert(result, line)
  end
  return result
end

-- Ejmastnak
local function get_visual(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- Non-math Fonts
  s(
    -- I use \\text{} a bit more commonly than the others so a 2-letter trigger is more convenient.
    { trig = "([^%w])tq", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet", dscr = "Text" },
    fmta("<>\\text{<>}", {
      l(l.CAPTURE1),
      d(1, get_visual),
    })
  ),
  s(
    { trig = "ttt", snippetType = "autosnippet", dscr = "Typewriter" },
    fmta("\\texttt{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "tit", snippetType = "autosnippet", dscr = "Italic" },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "tbt", snippetType = "autosnippet", dscr = "Bold" },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
  -- Math Fonts
}

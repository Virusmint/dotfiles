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

local M = {}

M = {
  s(
    { trig = "BEG", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
        <>
      \end{<>}
      ]],
      { i(1), i(0), rep(1) },
      { condition = line_begin }
    )
  ),
  s(
    { trig = "BSAL", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{align*}
        <>
      \end{align*}
      ]],
      { i(0) },
      { condition = line_begin }
    )
  ),
  s(
    { trig = "BEQ", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{equation}
        <>
      \end{equation}
      ]],
      { i(0) },
      { condition = line_begin }
    )
  ),
  s(
    { trig = "BEN", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{enumerate}[label=(\alph*)]
        \item <>
      \end{enumerate}
      ]],
      { i(0) }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "BIT", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{itemize}
        \item <>
      \end{itemize}
      ]],
      { i(0) }
    ),
    { condition = line_begin }
  ),
}

return M

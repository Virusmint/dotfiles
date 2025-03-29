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

return {
  s(
    { trig = "BEG", snippetType = "autosnippet", dscr = "Generic Environment" },
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
    { trig = "BQ", snippetType = "autosnippet", dscr = "Question Environment" },
    fmta(
      [[
        \begin{question}
          <>
        \end{question}
        \newpage
        ]],
      { i(0) },
      { condition = line_begin }
    )
  ),
  s(
    { trig = "BSAL", snippetType = "autosnippet", dscr = "Align* Environment" },
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
    { trig = "BEQ", snippetType = "autosnippet", dscr = "Equation Environment" },
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
    { trig = "BEN", snippetType = "autosnippet", "Enumerate Environment" },
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
    { trig = "BIT", snippetType = "autosnippet", dscr = "Itemize Environment" },
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
  -- Figures, Tables, etc.
  s(
    { trig = "BFIG", snippetType = "autosnippet", dscr = "Figure Environment" },
    fmta(
      [[
      \begin{figure}[H]
        \centering
        \includegraphics[width=0.5\textwidth]{<>}
        \caption{<>}
        \label{<>}
      \end{figure}
      ]],
      { i(1), i(2), i(3) }
    ),
    { condition = line_begin }
  ),
}

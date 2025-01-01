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
local k = require("luasnip.nodes.key_indexer").new_key

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local function fn(
  args, -- text from i(2) in this example i.e. { { "456" } }
  parent, -- parent snippet or parent node
  user_args -- user_args from opts.user_args
)
  return "[" .. args[1][1] .. user_args .. "]"
end

return {
  -- General

  -- s("trig", {
  --   i(1, "text_of_first"),
  --   i(2, { "first_line_of_second", "second_line_of_second" }),
  --   f(function(args, snip)
  --     -- just concat first lines of both.
  --     return args[1][1] .. args[2][1]
  --   end, { ai[2], ai[1] }),
  -- }),
  s(
    { trig = "href", dscr = "hyperrer package for url links" },
    fmta("\\href{<>}{<>}", { i(1, "url"), i(2, "display name") })
  ),
  s({ trig = "tt ", snippetType = "autosnippet" }, fmta("\\texttt{<>}", { i(1) })),
  s(
    { trig = "ti ", snippetType = "autosnippet", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "tb ", snippetType = "autosnippet", dscr = "Expands 'tbb' into LaTeX's textbf{} command." },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
  -- Symbols
  s({ trig = "inf ", snippetType = "autosnippet" }, {
    t("\\infty"),
  }),
  s({ trig = "ninf ", snippetType = "autosnippet" }, {
    t("-\\infty"),
  }),
  s({ trig = ";x", snippetType = "autosnippet" }, {
    t("\\times"),
  }),
  -- Math
  s({ trig = "fa ", snippetType = "autosnippet" }, fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  -- s({ trig = "", snippetType = "autosnippet" }, { not sure how to do this for now
  --   t("\\lVert "),
  --   i(1),
  --   t(" \\rVert"),
  -- }),
  s({ trig = "abs ", snippetType = "autosnippet" }, {
    t("\\lvert "),
    i(1),
    t(" \\rvert"),
  }),
  -- Trigonometry
  s({ trig = "sin ", snippetType = "autosnippet" }, {
    t("\\sin("),
    i(1),
    t(")"),
  }),
  s({ trig = "cos ", snippetType = "autosnippet" }, {
    t("\\cos("),
    i(1),
    t(")"),
  }),
  s({ trig = "tan ", snippetType = "autosnippet" }, {
    t("\\tan("),
    i(1),
    t(")"),
  }),
  -- Calculus
  s({ trig = "lm ", snippetType = "autosnippet" }, fmta("\\lim_{{<> \to <>}} <>", { i(1), i(2), i(3) })),
  s({ trig = "de ", snippetType = "autosnippet" }, fmta("\\frac{d<>}{d<>}", { i(1), i(2) })),
  s({ trig = "int ", snippetType = "autosnippet" }, fmta("\\int_{<>}^{<>} <> , d<> ", { i(1), i(2), i(3), i(4) })),
  -- Sets
  s({ trig = ";N", snippetType = "autosnippet" }, {
    t("\\mathbb{N}"),
  }),
  s({ trig = ";Z", snippetType = "autosnippet" }, {
    t("\\mathbb{Z}"),
  }),
  s({ trig = ";Q", snippetType = "autosnippet" }, {
    t("\\mathbb{Q}"),
  }),
  s({ trig = ";R", snippetType = "autosnippet" }, {
    t("\\mathbb{R}"),
  }),
  -- s({ trig = "O ", snippetType = "autosnippet" }, {
  --   t("\\mathbb{O}"),
  -- }),

  -- Greek letters
  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("\\alpha"),
  }),
  s({ trig = ";b", snippetType = "autosnippet" }, {
    t("\\beta"),
  }),
  s({ trig = ";g", snippetType = "autosnippet" }, {
    t("\\gamma"),
  }),
  s({ trig = ";d", snippetType = "autosnippet" }, {
    t("\\delta"),
  }),
  s({ trig = ";e", snippetType = "autosnippet" }, {
    t("\\epsilon"),
  }),
  s({ trig = ";ve", snippetType = "autosnippet" }, {
    t("\\varepsilon"),
  }),
  s({ trig = ";n", snippetType = "autosnippet" }, {
    t("\\eta"),
  }),
  s({ trig = ";l", snippetType = "autosnippet" }, {
    t("\\lambda"),
  }),
  s({ trig = ";m", snippetType = "autosnippet" }, {
    t("\\mu"),
  }),
  s({ trig = ";s", snippetType = "autosnippet" }, {
    t("\\sigma"),
  }),
  s({ trig = ";t", snippetType = "autosnippet" }, {
    t("\\theta"),
  }),
  s({ trig = ";w", snippetType = "autosnippet" }, {
    t("\\omega"),
  }),
  s(
    { trig = "BE", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
      ]],
      { i(1), i(0), rep(1) }
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
      { i(0) }
    )
  ),
  s(
    { trig = "BSEQ" },
    fmta(
      [[
      \begin{equation}
          <>
      \end{equation}
      ]],
      { i(0) }
    )
  ),
  s(
    { trig = "BEN", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{enumerate}[label=\alph*]
          <>
      \end{enumerate}
      ]],
      { i(0) }
    )
  ),
}

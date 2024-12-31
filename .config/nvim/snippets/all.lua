local ls = require("luasnip")
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node

return {
  -- Basic
  s({ trig = "fa ", snippetType = "autosnippet" }, {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),
  -- Integral
  s({ trig = "int ", snippetType = "autosnippet" }, {
    t("\\int_{"),
    i(1),
    t("}^{"),
    i(2),
    t("} "),
    i(3),
    t(" \\,d "),
    i(4),
  }),
  -- Sets
  s({ trig = "N ", snippetType = "autosnippet" }, {
    t("\\mathbb{N}"),
  }),
  s({ trig = "Z ", snippetType = "autosnippet" }, {
    t("\\mathbb{Z}"),
  }),
  s({ trig = "Q ", snippetType = "autosnippet" }, {
    t("\\mathbb{Q}"),
  }),
  s({ trig = "R ", snippetType = "autosnippet" }, {
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
  s({ trig = ";n", snippetType = "autosnippet" }, {
    t("\\eta"),
  }),
  s({ trig = ";l", snippetType = "autosnippet" }, {
    t("\\lambda"),
  }),
  s({ trig = ";m", snippetType = "autosnippet" }, {
    t("\\mu"),
  }),
  s({ trig = ";p", snippetType = "autosnippet" }, {
    t("\\pi"),
  }),
  s({ trig = ";s", snippetType = "autosnippet" }, {
    t("\\sigma"),
  }),
  -- Blocks
  s({ trig = "BSAL", snippetType = "autosnippet" }, {
    t("\\begin{align*}"),
    i(1),
    t("\\end{align*}"),
  }),
  s({ trig = "BSEQ", snippetType = "autosnippet" }, {
    t("\\begin{equation*}"),
    i(1),
    t("\\end{equation*}"),
  }),
  s({ trig = "BEN", snippetType = "autosnippet" }, {
    t("\\begin{enumerate}[label=\\alph*]"),
    i(1),
    t("\\end{enumerate}"),
  }),
}

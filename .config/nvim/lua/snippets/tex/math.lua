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

-- Custom Helpers
local tex = require("snippets.tex.utils").condition
local scaff = require("snippets.tex.utils").scaffolding

-- Ejmastnak
local function get_visual(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- TODO: function defs

return {
  -- Misc
  s({ trig = "ov", snippetType = "autosnippet", desc = "Overline" }, fmta("\\overline{<>}", { d(1, get_visual) }), {
    condition = tex.in_mathzone,
  }),
  s({ trig = "uv", snippetType = "autosnippet", desc = "Underline" }, fmta("\\underline{<>}", { d(1, get_visual) }), {
    condition = tex.in_mathzone,
  }),
  s({ trig = "vv", snippetType = "autosnippet", desc = "Vector" }, fmta("\\vec{<>}", { d(1, get_visual) }), {
    condition = tex.in_mathzone,
  }),
  s(
    { trig = "ub", snippetType = "autosnippet", desc = "Underbrace" },
    fmta("\\underbrace{<>}_{<>}", { d(1, get_visual), i(2) }),
    {
      condition = tex.in_mathzone,
    }
  ),
  s({ trig = "..", snippetType = "autosnippet", desc = "Ellipsis" }, { t("\\ldots") }, { condition = tex.in_mathzone }),
  s({ trig = "|.", snippetType = "autosnippet", desc = "Vertical Ellipsis" }, { t("\\vdots") }, {
    condition = tex.in_mathzone,
  }),
  s({ trig = "\\.", snippetType = "autosnippet", desc = "Diagonal Ellipsis" }, { t("\\ddots") }, {
    condition = tex.in_mathzone,
  }),
  -- Inline math
  s(
    { trig = "mk", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      l(l.CAPTURE1),
      d(1, get_visual),
    }),
    { condition = tex.in_text }
  ),

  -- Logical operators
  s({ trig = "leq", snippetType = "autosnippet", dscr = "\\leq" }, { t("\\leq") }, { condition = tex.in_mathzone }),
  s({ trig = "geq", snippetType = "autosnippet", dscr = "\\geq" }, { t("\\geq") }, { condition = tex.in_mathzone }),
  s({ trig = "neq", snippetType = "autosnippet", dscr = "\\neq" }, { t("\\neq") }, { condition = tex.in_mathzone }),
  s({ trig = "in ", snippetType = "autosnippet", dscr = "\\in" }, { t("\\in ") }, { condition = tex.in_mathzone }),
  s(
    { trig = "nin ", snippetType = "autosnippet", dscr = "\\notin" },
    { t("\\notin ") },
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "upto", snippetType = "autosnippet", dscr = "\\uparrow" },
    { t("\\uparrow") },
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "downto", snippetType = "autosnippet", dscr = "\\downarrow" },
    { t("\\downarrow") },
    { condition = tex.in_mathzone }
  ),
  -- Symbols
  s({ trig = "inf", snippetType = "autosnippet" }, { t("\\infty") }, { condition = tex.in_mathzone }),
  s({ trig = "ninf", snippetType = "autosnippet" }, { t("-\\infty") }, { condition = tex.in_mathzone }),
  s({ trig = "ns", snippetType = "autosnippet" }, { t("\\emptyset") }, { condition = tex.in_mathzone }),
  s({ trig = "s\\ ", snippetType = "autosnippet" }, { t("\\setminus ") }, { condition = tex.in_mathzone }),

  -- Aggregators
  s(
    { trig = "sm", snippetType = "autosnippet", dscr = "Summation" },
    fmta("\\sum_{<>}^{<>} ", { i(1, "i=0"), i(2, "\\infty") }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "prod", snippetType = "autosnippet", dscr = "Product" },
    c(1, {
      fmta("\\prod_{<>}^{<>} <> ", { i(1, "i=1"), i(2, "n"), i(3) }),
      fmta("\\prod_{<>} <> ", { i(1), i(2) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "UN", snippetType = "autosnippet", dscr = "Big Union" },
    c(1, {
      fmta("\\bigcup_{<>}^{<>} ", { i(1, "i=1"), i(2, "\\infty") }),
      fmta("\\bigcup_{<>} ", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "DUN", snippetType = "autosnippet", dscr = "Big Disjoint Union" },
    c(1, {
      fmta("\\bigsqcup_{<>}^{<>} ", { i(1, "i=1"), i(2, "\\infty") }),
      fmta("\\bigsqcup_{<>} ", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s({ trig = "cup", snippetType = "autosnippet", dscr = "Union" }, { t("\\cup ") }, { condition = tex.in_mathzone }),
  s(
    { trig = "dup", snippetType = "autosnippet", dscr = "Disjoint Union" },
    { t("\\sqcup ") },
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "IN", snippetType = "autosnippet", dscr = "Big Intersection" },
    c(1, {
      fmta("\\bigcap_{<>}^{<>} ", { i(1, "i=1"), i(2, "\\infty") }),
      fmta("\\bigcap_{<>} ", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "cap", snippetType = "autosnippet", dscr = "Intersection" },
    { t("\\cap ") },
    { condition = tex.in_mathzone }
  ),

  -- Subscripts and Superscripts
  s(
    {
      trig = "([%w%)%]%}]);",
      trigEngine = "pattern",
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Subscript",
    },
    fmta("<>_{<>} ", {
      l(l.CAPTURE1),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    {
      trig = "([%a%}])([%d])",
      trigEngine = "pattern",
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Subscript Basic Index",
    },
    fmta("<>_{<>} ", {
      l(l.CAPTURE1),
      l(l.CAPTURE2),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    {
      trig = "([%a%}])([ijk]) ",
      trigEngine = "pattern",
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Subscript Basic Index",
    },
    fmta("<>_{<>} ", {
      l(l.CAPTURE1),
      l(l.CAPTURE2),
    }),
    { condition = tex.in_mathzone }
  ),
  s({
    trig = "([%w%)%]%}]):",
    trigEngine = "pattern",
    wordTrig = false,
    snippetType = "autosnippet",
    dscr = "Superscript",
  }, fmta("<>^{<>}", { l(l.CAPTURE1), i(1) }), { condition = tex.in_mathzone }),
  s(
    { trig = "([%w%)%]%}])sa", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet", dscr = "Square" },
    fmta("<>^{-1}", { l(l.CAPTURE1) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])sd", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet", dscr = "Square" },
    fmta("<>^{2}", { l(l.CAPTURE1) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}])sf", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet", dscr = "Cube" },
    fmta("<>^{3}", {
      l(l.CAPTURE1),
    }),
    { condition = tex.in_mathzone }
  ),

  s(
    { trig = "ff", snippetType = "autosnippet", dscr = "Fraction" },
    fmta("\\frac{<>}{<>}", { d(1, get_visual), i(2) }),
    { condition = tex.in_mathzone }
  ),
  -- Basic Functions
  s(
    { trig = "norm", snippetType = "autosnippet" },
    fmta("\\lVert <> \\rVert ", { i(1) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "abs", snippetType = "autosnippet", dscr = "Absolute Value" },
    fmta("\\lvert <> \\rvert ", { i(1) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "sq", snippetType = "autosnippet", dscr = "Square Root" },
    fmta("\\sqrt{<>}", { i(1) }),
    { condition = tex.in_mathzone }
  ),

  -- Logic
  s({ trig = "fa", snippetType = "autosnippet", dscr = "∀" }, t("\\forall"), { condition = tex.in_mathzone }),
  s({ trig = "te", snippetType = "autosnippet", dscr = "∃" }, t("\\exists"), { condition = tex.in_mathzone }),
  s({ trig = "ih", snippetType = "autosnippet", dscr = "∈" }, { t("\\in") }, { condition = tex.in_mathzone }),
  s({ trig = "nih", snippetType = "autosnippet", dscr = "∉" }, { t("\\notin") }, { condition = tex.in_mathzone }),
  s({ trig = "iff", snippetType = "autosnippet", dscr = "<=>" }, { t("\\iff") }, { condition = tex.in_mathzone }),
  s({ trig = "mp", snippetType = "autosnippet", dscr = "=>" }, { t("\\implies") }, { condition = tex.in_mathzone }),
  s({ trig = "mpb", snippetType = "autosnippet", dscr = "<=" }, { t("\\impliedby") }, { condition = tex.in_mathzone }),
  s({ trig = "neg", snippetType = "autosnippet", dscr = "¬" }, { t("\\neg") }, { condition = tex.in_mathzone }),
  s({ trig = "and", snippetType = "autosnippet", dscr = "∧" }, { t("\\land") }, { condition = tex.in_mathzone }),
  s({ trig = "or", snippetType = "autosnippet", dscr = "∨" }, { t("\\lor") }, { condition = tex.in_mathzone }),

  -- Set Theory
  s({ trig = "seq", snippetType = "autosnippet", dscr = "⊆" }, { t("\\subseteq") }, { condition = tex.in_mathzone }),
  s({ trig = "ifm", snippetType = "autosnippet", dscr = "infimum" }, { t("\\inf") }, { condition = tex.in_mathzone }), -- Spelling to avoid conflict with "in"
  s({ trig = "sup", snippetType = "autosnippet", dscr = "supremum" }, { t("\\sup") }, { condition = tex.in_mathzone }),
  s(
    { trig = "ss", snippetType = "autosnippet", dscr = "Set Builder" },
    fmta("\\{ <> \\}", i(1)),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "sn", snippetType = "autosnippet", dscr = "Sequence" },
    fmta("\\{ <>_n \\}_{<>}^{<>}", { i(1), i(2, "n=1"), i(3, "\\infty") }),
    { condition = tex.in_mathzone }
  ),

  -- Trigonometry
  s({ trig = "sin", snippetType = "autosnippet" }, fmta("\\sin(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "cos", snippetType = "autosnippet" }, fmta("\\cos(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "tan", snippetType = "autosnippet" }, fmta("\\tan(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "csc", snippetType = "autosnippet" }, fmta("\\csc(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "sec", snippetType = "autosnippet" }, fmta("\\sec(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "cot", snippetType = "autosnippet" }, fmta("\\cot(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s(
    { trig = "([%A])ee", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e^{<>}", {
      l(l.CAPTURE1),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([%A])xp", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\exp{<>}", {
      l(l.CAPTURE1),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),

  -- Notation
  s(
    { trig = "fn", snippetType = "autosnippet" },
    fmta("<> : <> \\to <>", {
      i(1, "f"),
      i(2, "\\R"),
      i(3, "\\R"),
    }),
    { condition = tex.in_mathzone }
  ),

  -- Calculus
  s(
    { trig = "lm", snippetType = "autosnippet", dscr = "Limit" },
    c(1, {
      fmta("\\lim_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }),
      fmta("\\limsup_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }),
      fmta("\\liminf_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "dd", snippetType = "autosnippet", dscr = "Derivative" },
    fmta("\\dv{<>}{<>} ", { i(1), i(2, "x") }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "pd", snippetType = "autosnippet", dscr = "Partial Derivative" },
    fmta("\\frac{\\partial <>}{\\partial <>} ", { i(1), i(2) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "int", snippetType = "autosnippet", dscr = "Integral" },
    c(1, {
      fmta("\\int_{<>}^{<>} <> \\diff <> ", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4, "x") }),
      fmta("\\int_{<>} <> \\diff <> ", { i(1), i(2), i(3) }),
    }),
    { condition = tex.in_mathzone }
  ),

  -- Stats
  s({ trig = "~", snippetType = "autosnippet" }, { t("\\sim") }, { condition = tex.in_mathzone }),
  s(
    { trig = "\\E", snippetType = "autosnippet" },
    c(1, {
      fmta("\\mathbb{E}[<>]", { i(1) }),
      fmta("\\mathbb{E}\\left[ <> \\right]", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "\\Var", snippetType = "autosnippet" },
    c(1, {
      fmta("\\Var[<>]", { i(1) }),
      fmta("\\Var\\left[ <> \\right]", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "\\Pr", snippetType = "autosnippet" },
    c(1, {
      fmta("\\mathbb{P}(<>)", { i(1) }),
      fmta("\\mathbb{P}\\left( <> \\right)", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "\\Cov", snippetType = "autosnippet" },
    c(1, {
      fmta("\\text{{Cov}}[<>]", { i(1) }),
      fmta("\\text{{Cov}}\\left[ <> \\right]", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "\\Corr", snippetType = "autosnippet" },
    c(1, {
      fmta("\\text{{Corr}}[<>]", { i(1) }),
      fmta("\\text{{Corr}}\\left[ <> \\right]", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),

  -- Equation Stuff
  s(
    { trig = "([%w%s])==", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>&= ", {
      l(l.CAPTURE1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = ";=", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    { t("\\defeq ") },
    { condition = tex.in_mathzone }
  ),
  -- Postfixes
  s({
    trig = "([%u])perp",
    trigEngine = "pattern",
    wordTrig = false,
    snippetType = "autosnippet",
    dscr = "Vector Space Perp",
  }, fmta("<>^{\\perp}", { l(l.CAPTURE1) }), { condition = tex.in_mathzone }),

  -- Matrices
  -- TODO: allow for greek letters
  s(
    { trig = ",%.([%a])", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\mathbf{<>}", {
      l(l.CAPTURE1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    {
      trig = "([%}%)])([tT])",
      trigEngine = "pattern",
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Transpose",
    },
    fmta("<>^{\\top}", {
      l(l.CAPTURE1),
    }),
    { condition = tex.in_mathzone }
  ),

  -- TODO: Add quick to-\mathbb matrix snippet
  s(
    {
      trig = "([bBpvV])mat(%d+)x(%d+)([ar])",
      trigEngine = "pattern",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta(
      [[
      \begin{<type>matrix}<>
          <>
      \end{<type>matrix}
      ]],
      {
        type = f(function(_, snip)
          return snip.captures[1] -- captures matrix type
        end),

        f(function(_, snip)
          if snip.captures[4] == "a" then
            local out = string.rep("c", tonumber(snip.captures[3]) - 1) -- array for augment
            return "[" .. out .. "|c]"
          end
          return ""
        end),
        d(1, scaff.matrix),
      }
    ),
    { condition = tex.in_mathzone }
  ),

  s({ trig = "([^%w])(%u)%2", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" }, {
    f(function(_, snip)
      local letter = snip.captures[2]
      local pre = snip.captures[1]
      if tex.in_text() and pre ~= "$" then
        return pre .. "$\\mathcal{" .. letter .. "}$"
      else
        return pre .. "\\mathcal{" .. letter .. "}"
      end
    end),
  }),
}

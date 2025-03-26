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

local M = {}

local symbols = {}

local auto_backslash_specs = {
  "arcsin",
  "sin",
  "arccos",
  "cos",
  "arctan",
  "tan",
  "cot",
  "csc",
  "sec",
  "log",
  "ln",
  "exp",
  "ast",
  "star",
  "perp",
  "sup",
  "inf",
  "det",
  "max",
  "min",
  "argmax",
  "argmin",
}

-- for _, v in ipairs(auto_backslash_specs) do
--

-- LaTeX snippets
return {
  -- General
  s(
    { trig = "([%s])mk", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_text }
  ),
  s(
    { trig = "href", dscr = "hyperref package for url links", autosnippet = true },
    fmta("\\href{<>}{<>}", { i(1, "url"), i(2, "display name") })
  ),
  -- Math logical operators
  s({ trig = "leq", snippetType = "autosnippet", dscr = "\\leq" }, {
    t("\\leq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "geq", snippetType = "autosnippet", dscr = "\\geq" }, {
    t("\\geq"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "neq", snippetType = "autosnippet", dscr = "\\neq" }, {
    t("\\neq"),
  }, { condition = tex.in_mathzone }),

  -- Text
  s(
    { trig = "ttw", snippetType = "autosnippet" },
    fmta("\\text{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "ttt", snippetType = "autosnippet" },
    fmta("\\texttt{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "tte", snippetType = "autosnippet", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "ttb", snippetType = "autosnippet", dscr = "Expands 'tbb' into LaTeX's textbf{} command." },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
  -- Symbols
  s({ trig = "inf", snippetType = "autosnippet" }, {
    t("\\infty"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "ninf", snippetType = "autosnippet" }, {
    t("-\\infty"),
  }, { condition = tex.in_mathzone }),
  -- s({ trig = ";x", snippetType = "autosnippet" }, {
  --   t("\\times"),
  -- }, { condition = tex.in_mathzone }),

  -- Math
  s(
    { trig = "sm", snippetType = "autosnippet" },
    fmta("\\sum_{<>}^{<>} ", {
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),

  s(
    { trig = "prod", snippetType = "autosnippet" },
    c(1, {
      fmta("\\prod_{<>}^{<>} <> ", { i(1, "i=1"), i(2, "n"), i(3) }),
      fmta("\\prod_{<>} <> ", { i(1), i(2) }),
    }),
    { condition = tex.in_mathzone }
  ),

  -- Subscripts and superscripts
  s(
    { trig = "([%w%)%]%}]);", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}]):", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "ff", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}", { i(1), i(2) }),
    { condition = tex.in_mathzone }
  ),

  s(
    { trig = "norm", snippetType = "autosnippet" },
    fmta("\\lVert <> \\rVert ", { i(1) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "abs", snippetType = "autosnippet" },
    fmta("\\lvert <> \\rvert ", { i(1) }),
    { condition = tex.in_mathzone }
  ),
  s({ trig = "sqrt", snippetType = "autosnippet" }, fmta("\\sqrt{<>}", { i(1) }), { condition = tex.in_mathzone }),

  -- Logic
  s({ trig = "fa", snippetType = "autosnippet" }, t("\\forall"), { condition = tex.in_mathzone }),
  s({ trig = "te", snippetType = "autosnippet" }, t("\\exists"), { condition = tex.in_mathzone }),
  -- s({ trig = "in", snippetType = "autosnippet" }, {
  --   t("\\in"), -- this one's a bit special since it overlaps with int (integral) and inf (infinity)
  -- }, { condition = tex.in_mathzone }),
  s({ trig = "notin", snippetType = "autosnippet" }, {
    t("\\notin"),
  }, { condition = tex.in_mathzone }),
  s({ trig = "iff", snippetType = "autosnippet" }, {
    t("\\iff "),
  }, { condition = tex.in_mathzone }),
  s({ trig = "imp", snippetType = "autosnippet" }, {
    t("\\implies"),
  }, { condition = tex.in_mathzone }),

  -- Trigonometry
  s({ trig = "sin", snippetType = "autosnippet" }, fmta("\\sin(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "cos", snippetType = "autosnippet" }, fmta("\\cos(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s({ trig = "tan", snippetType = "autosnippet" }, fmta("\\tan(<>)", { i(1) }), { condition = tex.in_mathzone }),
  s(
    { trig = "([%A])ee", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- s(
  --
  -- )
  -- Calculus
  s(
    { trig = "lm", snippetType = "autosnippet" },
    fmta("\\lim_{<> \\to <>} <>", { i(1), i(2), i(3) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "dd", snippetType = "autosnippet" },
    fmta("\\dv{<>}{<>}", { i(1), i(2, "x") }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "pd", snippetType = "autosnippet" },
    fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = "int", snippetType = "autosnippet" },
    c(1, {
      fmta("\\int_{<>}^{<>} <> \\diff <> ", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4, "x") }),
      fmta("\\int_{<>} <> \\diff <> ", { i(1), i(2), i(3) }),
    }),
    { condition = tex.in_mathzone }
  ),

  -- Stats
  s(
    { trig = "\\E", snippetType = "autosnippet" },
    c(1, {
      fmta("\\mathbb{E}[<>]", { i(1) }),
      fmta("\\mathbb{E}\\left[ <> \\right]", { i(1) }),
    }),
    { condition = tex.in_mathzone }
  ),
  -- Sets
  -- s({ trig = ";N", snippetType = "autosnippet" }, {
  --   t("\\mathbb{N}"),
  -- }, { condition = tex.in_mathzone }),
  -- s({ trig = ";Z", snippetType = "autosnippet" }, {
  --   t("\\mathbb{Z}"),
  -- }, { condition = tex.in_mathzone }),
  -- s({ trig = ";Q", snippetType = "autosnippet" }, {
  --   t("\\mathbb{Q}"),
  -- }, { condition = tex.in_mathzone }),
  -- s({ trig = ";R", snippetType = "autosnippet" }, {
  --   t("\\mathbb{R}"),
  -- }, { condition = tex.in_mathzone }),
  -- s({ trig = "O ", snippetType = "autosnippet" }, {
  --   t("\\mathbb{O}"),
  -- }),

  -- Greek letters
  -- s({ trig = ";a", snippetType = "autosnippet" }, {
  --   t("\\alpha"),
  -- }),
  -- s({ trig = ";b", snippetType = "autosnippet" }, {
  --   t("\\beta"),
  -- }),
  -- s({ trig = ";g", snippetType = "autosnippet" }, {
  --   t("\\gamma"),
  -- }),
  -- s({ trig = ";d", snippetType = "autosnippet" }, {
  --   t("\\delta"),
  -- }),
  -- s({ trig = ";e", snippetType = "autosnippet" }, {
  --   t("\\epsilon"),
  -- }),
  -- s({ trig = ";ve", snippetType = "autosnippet" }, {
  --   t("\\varepsilon"),
  -- }),
  -- s({ trig = ";n", snippetType = "autosnippet" }, {
  --   t("\\eta"),
  -- }),
  -- s({ trig = ";l", snippetType = "autosnippet" }, {
  --   t("\\lambda"),
  -- }),
  -- s({ trig = ";m", snippetType = "autosnippet" }, {
  --   t("\\mu"),
  -- }),
  -- s({ trig = ";s", snippetType = "autosnippet" }, {
  --   t("\\sigma"),
  -- }),
  -- s({ trig = ";t", snippetType = "autosnippet" }, {
  --   t("\\theta"),
  -- }),
  -- s({ trig = ";w", snippetType = "autosnippet" }, {
  --   t("\\omega"),
  -- }),
  s(
    { trig = "([%w%s])==", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>&= ", {
      f(function(_, snip)
        local cap = snip.captures[1]
        if cap == " " then
          return cap
        end
        return cap .. " "
      end),
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = ":=", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    { t("\\defeq ") },
    { condition = tex.in_mathzone }
  ),
  -- TODO: Vector space perp

  -- Matrix Notation
  s(
    { trig = ";([%a])", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\mathbf{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex.in_mathzone }
  ),
  -- Transpose
  s(
    { trig = "([%}])T", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{\\top}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
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
}

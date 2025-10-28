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

-- Custom Helpers
local tex = require("snippets.tex.utils").condition

local function create_conditional_snippet(trig, cmd)
  return s({ trig = trig, snippetType = "autosnippet" }, {
    f(function()
      if tex.in_mathzone() then
        return "\\" .. cmd
      else
        return "$\\" .. cmd .. "$"
      end
    end),
  })
end

local greek_letters = {
  -- Lowercase
  { ";a", "alpha" },
  { ";b", "beta" },
  { ";g", "gamma" },
  { ";d", "delta" },
  { ";e", "epsilon" },
  { ";ve", "varepsilon" },
  { ";z", "zeta" },
  { ";h", "eta" },
  { ";t", "theta" },
  { ";i", "iota" },
  { ";k", "kappa" },
  { ";l", "lambda" },
  { ";m", "mu" },
  { ";n", "nu" },
  { ";x", "xi" },
  { ";pi", "pi" },
  { ";p", "phi" },
  { ";vp", "varphi" },
  { ";r", "rho" },
  { ";s", "sigma" },
  { ";ta", "tau" },
  { ";u", "upsilon" },
  { ";ph", "phi" },
  { ";ch", "chi" },
  { ";ps", "psi" },
  { ";w", "omega" },
  --; Uppercase
  { ";A", "Alpha" },
  { ";B", "Beta" },
  { ";G", "Gamma" },
  { ";D", "Delta" },
  { ";E", "Epsilon" },
  { ";Z", "Zeta" },
  { ";H", "Eta" },
  { ";T", "Theta" },
  { ";I", "Iota" },
  { ";K", "Kappa" },
  { ";L", "Lambda" },
  { ";M", "Mu" },
  { ";N", "Nu" },
  { ";X", "Xi" },
  { ";P", "Pi" },
  { ";R", "Rho" },
  { ";S", "Sigma" },
  { ";Ta", "Tau" },
  { ";U", "Upsilon" },
  { ";Ph", "Phi" },
  { ";Ch", "Chi" },
  { ";Ps", "Psi" },
  { ";W", "Omega" },
}

for _, pair in ipairs(greek_letters) do
  local trig, cmd = pair[1], pair[2]
  table.insert(M, create_conditional_snippet(trig, cmd))
end

table.insert(
  M,
  s({ trig = "([%u])+", trigEngine = "pattern", wordTrig = false, snippetType = "autosnippet" }, {
    f(function(_, snip)
      local letter = snip.captures[1]
      vim.notify(vim.inspect(snip))
      if tex.in_mathzone() then
        return snip.captures[1] .. "\\mathcal{" .. letter .. "}"
      else
        return snip.captures[1] .. "$\\mathcal{" .. letter .. "}$"
      end
    end),
  })
)

return M

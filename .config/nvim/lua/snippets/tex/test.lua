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
local function fn(
  args, -- text from i(2) in this example i.e. { { "456" } }
  parent, -- parent snippet or parent node
  user_args -- user_args from opts.user_args
)
  return "[" .. args[1][1] .. user_args .. "]"
end

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

return {
  s("bash", f(bash, {}, { user_args = { "ls" } })),
  -- s(
  --   "trig",
  --   c(1, {
  --     t("Ugh boring, a text node"),
  --     i(nil, "At least I can edit something now..."),
  --     f(function(args)
  --       return "Still only counts as text!!"
  --     end, {}),
  --   })
  -- ),
  --
  s(
    "trig",
    sn(nil, {
      t("basically just text "),
      i(1, "And an insertNode."),
    })
  ),
}

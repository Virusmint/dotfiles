local ls = require("luasnip")

local M = {}

ls.filetype_extend("rnoweb", { "r", "rmd", "tex" })

return M

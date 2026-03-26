return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["tex-fmt"] = {
          prepend_args = { "--nowrap" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        tex = { "tex-fmt" },
        rnoweb = { "tex-fmt" },
      },
    },
  },
}

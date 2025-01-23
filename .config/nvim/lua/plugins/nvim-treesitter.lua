return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     opts.highlight = opts.highlight or {}
  --     if type(opts.ensure_installed) == "table" then
  --       vim.list_extend(opts.ensure_installed, { "bibtex" })
  --     end
  --     if type(opts.highlight.disable) == "table" then
  --       vim.list_extend(opts.highlight.disable, { "latex" })
  --     else
  --       opts.highlight.disable = { "latex" }
  --     end
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "bibtex",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "r",
        "regex",
        "rnoweb",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "hyprlang", -- Added for Hyprlang support
      },
    },
  },
}

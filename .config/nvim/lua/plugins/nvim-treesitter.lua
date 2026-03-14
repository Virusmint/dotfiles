return {
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
        -- "latex", -- Vimtex already has syntax highlighting compatible with luasnip
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
        -- "rnoweb",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "hyprlang", -- Added for Hyprlang support
      },
      highlight = {
        enable = true,
        disable = { "latex", "rnoweb" },
      },
    },
  },
}

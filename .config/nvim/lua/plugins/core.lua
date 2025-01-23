return {
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }
      local opts = {
        servers = {
          r_language_server = {
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
                or require("lspconfig.util").find_git_ancestor(fname)
                or vim.loop.os_homedir()
            end,
          },
        },
      }
      return opts
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }

      opts.servers.r_language_server = {
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
            or require("lspconfig.util").find_git_ancestor(fname)
            or vim.loop.os_homedir()
        end,
      }
    end,
  },
}

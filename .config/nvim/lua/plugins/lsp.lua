return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }

      vim.list_extend(opts.inlay_hints.exclude, {
        "tex",
      })
    end,
  },
}

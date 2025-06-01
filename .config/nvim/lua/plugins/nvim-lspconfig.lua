return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }

      vim.list_extend(opts.inlay_hints.exclude, {
        "tex",
      })
      opts.setup = {
        pyright = function(_, opts)
          require("lspconfig").pyright.setup({
            settings = {
              pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  ignore = { "*" },
                },
              },
            },
          })
          return true
        end,
        ["*"] = function(server, opts) end,
      }
    end,
  },
}

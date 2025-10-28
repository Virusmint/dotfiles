return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }
      --
      -- Disable tex inlay hints (particularly for texlab lsp)
      vim.list_extend(opts.inlay_hints.exclude, {
        "tex",
      })
      opts.servers = {
        ["*"] = {
          keys = {
            { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", has = "definition" },
          },
        },
      }
      opts.setup = {
        -- https://github.com/latex-lsp/texlab/wiki/Configuration
        texlab = function(_, opts)
          require("lspconfig").texlab.setup({
            settings = {
              texlab = {
                inlayHints = {
                  labelReferences = false,
                },
              },
            },
          })
          return true
        end,
        -- https://docs.astral.sh/ruff/editors/setup/#neovim
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

return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", mode = "n", silent = true },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", mode = "n", silent = true },
    },
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  {
    "nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  -- Colorschemes list
  {
    "sainnhe/gruvbox-material",
    config = function()
      -- Custom colors
      vim.g.gruvbox_material_colors_override = {
        bg0 = { "#121215", "233" },
        bg3 = { "#1a1b1e", "237" },
        red = { "#ff5b47", "167" },
        orange = { "#ed7e32", "208" },
        yellow = { "#eba721", "214" },
        green = { "#9ec234", "142" },
        aqua = { "#89ad7d", "108" },
        blue = { "#8ac6db", "109" },
        purple = { "#ed7bcd", "175" },
      }
      -- Custom highlight color for Visual mode
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
        pattern = "gruvbox-material",
        callback = function()
          vim.api.nvim_set_hl(0, "Visual", { bg = "#45403d" })
        end,
      })
    end,
  },
}

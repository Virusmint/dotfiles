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
    enabled = true,
    config = function()
      -- vim.g.gruvbox_material_transparent_background = "2"
      -- Custom colors
      vim.g.gruvbox_material_colors_override = {
        bg0 = { "#1a1b1e", "233" },
        red = { "#ff5b47", "167" },
        orange = { "#ed7e32", "208" },
        yellow = { "#eba721", "214" },
        green = { "#9ec234", "142" },
        aqua = { "#89ad7d", "108" },
        blue = { "#8ac6db", "109" },
        purple = { "#ed7bcd", "175" },
      }
    end,
  },
}

return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-verbose",
          "-file-line-error",
          "-auxdir=build", -- bundle aux files into build folder
          "-synctex=1", -- for forward-search
          "-interaction=nonstopmode",
          "-shell-escape",
        },
      }
    end,
  },
}

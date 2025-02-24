return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      local system = vim.fn.system("uname")
      system = system:gsub("%s+", "")

      if system == "Darwin" then -- macOS
        -- Zathura hardly works on macOS silicon. Skim is a good alternative.
        vim.g.vimtex_view_method = "skim"
      elseif system == "Linux" then
        vim.g.vimtex_view_method = "zathura"
      end
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "build",
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-shell-escape",
        },
      }
    end,
  },
}

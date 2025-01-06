return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      local system = vim.fn.system("uname")
      system = system:gsub("%s+", "")

      if system == "Darwin" then -- macOS
        vim.g.vimtex_view_method = "skim" -- Zathura hardly works on macOS silicon
      elseif system == "Linux" then
        vim.g.vimtex_view_method = "zathura"
      end
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-verbose",
          "-file-line-error",
          "-auxdir=build",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-shell-escape",
        },
      }
    end,
  },
}

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Favor Pyright textDocument/hover: https://docs.astral.sh/ruff/editors/setup/#neovim
autocmd("LspAttach", {
  group = augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

-- Load custom luasnip snippets for specific courses when opening .tex files
autocmd("BufRead", {
  pattern = "*.tex",
  callback = function()
    local filepath = vim.fn.expand("%:p")
    local course_root = string.match(filepath, "(.-/McGill/bachelor%-%d+/%u%d%d%d)")
    if not course_root then
      return
    end
    local luasnip_dir = course_root .. "/luasnip/"
    if vim.fn.isdirectory(luasnip_dir) == 1 then
      require("luasnip.loaders.from_lua").load({ paths = luasnip_dir })
    end
  end,
  desc = "Load custom LuaSnip snippets based on the course in the file path",
})

-- Disable nvim-treesitter syntax highlighting for Rnoweb. LaTeX already handled by Vimtex
autocmd("FileType", {
  pattern = { "rnoweb" },
  callback = function()
    -- Kill Treesitter
    vim.treesitter.stop()
  end,
})

-- Wrap and enable spellcheck for markdown, tex, and rnoweb files
autocmd("FileType", {
  pattern = { "markdown", "tex", "rnoweb" },
  command = "setlocal wrap spell",
})

-- C shiftwidth to 4
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.shiftwidth = 4
  end,
})

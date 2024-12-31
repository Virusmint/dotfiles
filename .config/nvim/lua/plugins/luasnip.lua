return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          -- require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/luasnip/" } })
          require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets/" } })
        end,
      },
    },
    opts = function()
      local ls = require("luasnip")
      local opts = {
        history = true,
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
      }
      -- add snippet_forward action
      LazyVim.cmp.actions.snippet_forward = function()
        if ls.jumpable(1) then
          print("bruh")
          ls.jump(1)
          return true
        end
      end
      LazyVim.cmp.actions.snippet_stop = function()
        if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
          require("luasnip").unlink_current()
          return true
        end
      end
      return opts
    end,
  },
}

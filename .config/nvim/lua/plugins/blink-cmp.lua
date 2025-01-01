-- http://www.lazyvim.org/extras/coding/blink
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        LazyVim.cmp.map({ "ai_accept" }), -- LazyVim.cmp.actions
        "fallback",
      },
      ["<C-p>"] = {}, -- disable completion navigation
      ["<C-n>"] = {}, -- disable completion navigation
      ["<C-y>"] = {}, -- disable default LazyVim completion
    },
    completion = {
      trigger = {
        show_in_snippet = false, -- remove completions inside snippets
        show_on_insert_on_trigger_character = false, -- annoying completion trigger
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    -- Luasnip setup
    sources = {
      default = { "lsp", "luasnip", "path", "buffer" },
      providers = {
        -- lsp = {
        --   name = "lsp",
        --   enabled = true,
        --   module = "blink.cmp.sources.lsp",
        --   kind = "LSP",
        --   fallbacks = { "snippets", "luasnip", "buffer" },
        --   score_offset = 100,
        -- },
        luasnip = {
          name = "luasnip",
          enabled = true,
          module = "blink.cmp.sources.luasnip",
          fallbacks = { "snippets" },
          score_offset = 95,
        },
      },
    },
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
  },
}

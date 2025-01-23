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
        -- LazyVim.cmp.map({ "ai_accept" }), -- LazyVim.cmp.actions
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
    snippets = {
      preset = "luasnip",
    },
  },
}

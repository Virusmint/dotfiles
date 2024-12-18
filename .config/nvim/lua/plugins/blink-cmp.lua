-- http://www.lazyvim.org/extras/coding/blink
return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      -- Override LazyVim default keymaps
      ["<C-p>"] = {},
      ["<C-n>"] = {},
      ["<C-y>"] = {},
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
  },
}

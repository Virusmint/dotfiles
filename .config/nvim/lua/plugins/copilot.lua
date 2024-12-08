return {
  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- Github Copilot
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true, -- TOGGLE SUGGESTION
        auto_trigger = true, -- auto trigger suggestion
        debounce = 75,
        keymap = {
          accept = false,
          accept_word = "<C-w>",
          accept_line = "<C-j>",
          next = false,
          prev = false,
          dismiss = false,
        },
      },
    },
    config = function(_, opts)
      local cmp = require("cmp")
      local copilot = require("copilot.suggestion")
      local luasnip = require("luasnip")

      require("copilot").setup(opts)

      ---@param trigger boolean
      local function set_trigger(trigger)
        if not trigger and copilot.is_visible() then
          copilot.dismiss()
        end
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
      end

      -- Hide suggestions when the completion menu is open.
      cmp.event:on("menu_opened", function()
        set_trigger(false)
      end)
      cmp.event:on("menu_closed", function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
      end)
      -- Map suggestion accept to <Tab> when suggestion appears

      vim.api.nvim_create_autocmd("User", {
        desc = "Disable Copilot inside snippets",
        pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
        callback = function()
          set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
      })
    end,
  },
  -- Lualine integration
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local Util = require("lazyvim.util")
      local colors = {
        [""] = Util.ui.fg("Special"),
        ["Normal"] = Util.ui.fg("Special"),
        ["Warning"] = Util.ui.fg("DiagnosticError"),
        ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
      }
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require("lazyvim.config").icons.kinds.Copilot
          local status = require("copilot.api").status.data
          return icon .. (status.message or "")
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
        color = function()
          if not package.loaded["copilot"] then
            return
          end
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end,
      })
    end,
  },
}

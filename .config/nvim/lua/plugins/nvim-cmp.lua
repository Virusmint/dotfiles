return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "L3MON4D3/LuaSnip",
        opts = function()
            local types = require("luasnip.utils.types")
            return {
                -- Display cursor-like placeholders for unvisited nodes in the snippet
                ext_opts = {
                    [types.insertNode] = {
                        unvisited = {
                            virt_text = { { "|", "Conceal" } },
                            virt_text_pos = "inline",
                        },
                    },
                    [types.exitNode] = {
                        unvisited = {
                            virt_text = { { "|", "Conceal" } },
                            virt_text_pos = "inline",
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            local luasnip = require("luasnip")
            luasnip.setup(opts)
        end,
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_)
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        -- local symbol_kinds = require("icons").symbol_kinds
        local winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"
        -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        --
        return {
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = winhighlight,
                    scrollbar = true,
                },
                documentation = {
                    border = "rounded",
                    winhighlight = winhighlight,
                    max_height = math.floor(vim.o.lines * 0.5),
                    max_width = math.floor(vim.o.columns * 0.4),
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                }),
                ["/"] = cmp.mapping.close(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                -- Overload tab to accept Copilot suggestions.
                ["<C-Enter>"] = cmp.mapping(function(fallback)
                    local copilot = require("copilot.suggestion")
                    if copilot.is_visible() then
                        copilot.accept()
                    elseif vim.env.SNIPPET and vim.snippet.jumpable(1) then
                        vim.snippet.jump(1)
                    elseif not vim.env.SNIPPET and luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if vim.env.SNIPPET and vim.snippet.jumpable(-1) then
                        vim.snippet.jump(-1)
                    elseif not vim.env.SNIPPET and luasnip.expand_or_locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer", keyword_length = 4 },
            }),
        }
    end,
    config = function(_, opts)
        local cmp = require("cmp")
        cmp.setup(opts)
    end,
}

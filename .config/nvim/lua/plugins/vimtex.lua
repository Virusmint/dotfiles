return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "skim"
            vim.keymap.set("n", "<localleader>", '<cmd>lua require("which-key").show("\\\\")<cr>')
            vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
            vim.g.vimtex_view_skim_sync = 1
            vim.g.vimtex_view_skim_activate = 1
        end,
    },
}

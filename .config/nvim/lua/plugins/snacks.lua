return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⣤⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⡾⠛⠙⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡿⣆⠀⠉⢙⡛⠿⣿⠗⠲⠖⢲⡆
⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⢸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣃⡈⠻⣾⣇⠀⠸⠁⠀⢹⡗⠀⠀⣸⡇
⠀⠀⠀⣰⡟⠁⠀⠀⠀⠀⠘⣿⡾⠀⠀⡄⠀⣀⣠⣴⣶⠿⢻⡿⠛⢯⣁⣠⡟⠉⠙⠳⢶⣶⣯⣁⣀⣴⡿⠃
⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⣿⣟⣛⣉⣁⣀⣠⡟⠑⠀⠀⣰⠏⠀⠀⠀⠀⠀⠈⠉⠉⠛⠉⠀⠀
⠀⠀⠈⠀⠀⢀⣀⣤⣤⣶⣶⣿⣿⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⠛⢶⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⡇⠀⠀⠸⡇⢀⣠⣄⡀⠀⠀⠀⠀
⣾⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢻⡟⣿⣏⡛⠻⠿⠿⠿⠿⠛⠋⣡⣴⣿⠇⠀⠀⠀⣿⠋⣏⠉⢻⣆⠀⠀⠀
⣿⠀⣿⣿⣿⣿⣿⣿⣿⠿⠋⣠⣾⠁⠸⣿⣿⣷⣶⣶⣤⣶⣾⣿⣿⣿⡟⡀⠀⠀⠀⣿⡾⠟⢻⡄⢻⣆⠀⠀
⣿⠀⣿⣧⣉⡉⢉⣉⣤⣴⣿⣿⠏⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠃⠀⠀⠀⣿⠀⠀⣼⠇⢈⣿⠀⠀
⢿⡀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣯⣶⡾⠟⣷⣦⠈⠉⠛⠛⠛⠋⢻⡿⠃⠀⠀⠀⠀⢀⡏⢀⣾⡟⠀⣼⡟⠀⠀
⢸⡇⠀⠈⠛⠿⠿⠿⠿⠛⠉⠙⠿⠿⠿⠛⠁⠀⠀⠀⠀⠀⣴⡿⠁⠀⠀⠀⠀⠀⢸⡿⠛⠉⢀⣼⠟⠀⠀⠀
⠘⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⠋⠀⠀⠀⠀⠀⠀⢠⣿⠁⢀⣴⡿⠋⠀⠀⠀⠀
⠀⢿⡆⠀⠀⠀⠠⣤⣀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡶⠟⠋⠀⠀⠀⠀⠀⠀⠀⢀⣾⡧⠶⠛⠉⠀⠀⠀⠀⠀⠀
⠀⠈⣿⡀⠀⠀⠀⠈⠙⠻⠶⢶⣶⠶⠶⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠘⢿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠈⠙⢷⣦⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠉⠛⠻⢷⣶⡶⢤⣤⣤⣤⣤⣤⣶⠶⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
 ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 0.5 },
        -- { section = "startup" }, -- remove startup
      },
    },
    lazygit = {
      theme = {
        [241] = { fg = "Special" },
        activeBorderColor = { fg = "MatchParen", bold = true },
        cherryPickedCommitBgColor = { fg = "Identifier" },
        cherryPickedCommitFgColor = { fg = "Function" },
        defaultFgColor = { fg = "Normal" },
        inactiveBorderColor = { fg = "FloatBorder" },
        optionsTextColor = { fg = "Function" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
        selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
        unstagedChangesColor = { fg = "DiagnosticError" },
      },
    },

    styles = {
      notification_history = {
        width = 0.8,
        height = 0.8,
        minimal = true,
        wo = {
          wrap = true,
        },
      },
    },
  },
}

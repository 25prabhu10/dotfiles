return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  ---@class wk.Opts
  opts = {
    preset = "modern",
    icons = {
      mappings = true,
      keys = {},
    },
    spec = {
      { "[", group = "prev" },
      { "]", group = "next" },
      { "gr", group = "lsp commands" },
      { "<Leader><Tab>", group = "tabs" },
      { "<Leader>c", group = "code" },
      --{ "<Leader>d", group = "debug" },
      { "<Leader>f", group = "file/find" },
      { "<Leader>g", group = "goto/git" },
      { "<Leader>gg", group = "git" },
      { "<Leader>s", group = "search" },
      { "<Leader>r", group = "refactor" },
      { "<Leader>rb", group = "block" },
      { "<Leader>w", group = "workspace/panes" },
    },
  },
}

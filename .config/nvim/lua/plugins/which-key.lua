return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    ---@type wk.Win.opts
    win = {
      border = "rounded",
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  -- config = function()
  --   -- disable hints for certain operators
  --   -- local presets = require "which-key.plugins.presets"
  --   -- presets.operators["v"] = nil

  --   vim.o.timeout = true
  --   vim.o.timeoutlen = 500

  --   local wk = require "which-key"

  --   wk.setup {
  --     icons = {
  --       mappings = true,
  --       keys = {},
  --     },
  --     win = {
  --       border = "rounded",
  --     },
  --   }

  --   wk.add {
  --     { "]", group = "next" },
  --     { "[", group = "prev" },
  --     { "<Leader><Tab>", group = "tabs" },
  --     { "<Leader>b", group = "buffer" },
  --     { "<Leader>c", group = "code" },
  --     { "<Leader>d", group = "debug" },
  --     { "<Leader>da", group = "adapters" },
  --     { "<Leader>f", group = "file/find" },
  --     { "<Leader>g", group = "goto/git" },
  --     { "<Leader>gg", group = "git" },
  --     { "<Leader>gh", group = "hunks" },
  --     --{  "<Leader>q" } , group = "quit/session",
  --     { "<Leader>s", group = "search" },
  --     { "<Leader>u", group = "ui" },
  --     { "<Leader>w", group = "workspace/panes" },
  --     { "<Leader>x", group = "diagnostics/quickfix" },
  --   }
  -- end,
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    -- disable hints for certain operators
    -- local presets = require "which-key.plugins.presets"
    -- presets.operators["v"] = nil
    -- presets.operators["c"] = nil
    -- presets.operators["d"] = nil
    -- presets.operators["y"] = nil

    vim.o.timeout = true
    vim.o.timeoutlen = 500

    local wk = require "which-key"

    wk.setup {
      window = {
        border = "rounded",
      },
    }

    wk.register {
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<Leader><Tab>"] = { name = "+tabs" },
      ["<Leader>b"] = { name = "+buffer" },
      ["<Leader>c"] = { name = "+code" },
      ["<Leader>d"] = { name = "+debug" },
      ["<Leader>da"] = { name = "+adapters" },
      ["<Leader>f"] = { name = "+file/find" },
      ["<Leader>g"] = { name = "+goto/git" },
      ["<Leader>gg"] = { name = "+git" },
      ["<Leader>gh"] = { name = "+hunks" },
      -- ["<Leader>q"] = { name = "+quit/session" },
      ["<Leader>s"] = { name = "+search" },
      ["<Leader>u"] = { name = "+ui" },
      ["<Leader>w"] = { name = "+workspace/panes" },
      ["<Leader>x"] = { name = "+diagnostics/quickfix" },
    }
  end,
}

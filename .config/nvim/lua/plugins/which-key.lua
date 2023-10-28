return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
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
    },
  },
  config = function(_, opts)
    -- disable hints for certain operators
    -- local presets = require "which-key.plugins.presets"
    -- presets.operators["v"] = nil
    -- presets.operators["c"] = nil
    -- presets.operators["d"] = nil
    -- presets.operators["y"] = nil

    local wk = require "which-key"

    wk.setup {}
    wk.register(opts.defaults)
  end,
}

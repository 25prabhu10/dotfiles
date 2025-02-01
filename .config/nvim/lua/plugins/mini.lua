return {
  {
    "echasnovski/mini.nvim",
    version = "*",

    config = function()
      local status_line = require "mini.statusline"
      status_line.setup {}
    end,
  },
}


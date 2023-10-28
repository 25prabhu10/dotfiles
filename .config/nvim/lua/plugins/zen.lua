return {
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 1,
          -- height = 0.9,
          -- width = 140,
          options = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
            list = false,
            cursorline = false,
          },
        },
        plugins = {
          alacritty = {
            enabled = true,
            font = "8", -- font size
          },
        },
      }
    end,
  },
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
  },
}

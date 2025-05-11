return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>re",
        function()
          return require("refactoring").refactor "Extract Function"
        end,
        expr = true,
        desc = "Extract Function",
        mode = { "n", "x" },
      },
      {
        "<leader>rf",
        function()
          return require("refactoring").refactor "Extract Function To File"
        end,
        expr = true,
        desc = "Extract Function To File",
        mode = { "n", "x" },
      },
      {
        "<leader>rv",
        function()
          return require("refactoring").refactor "Extract Variable"
        end,
        expr = true,
        desc = "Extract Variable",
        mode = { "n", "x" },
      },
      {
        "<leader>rI",
        function()
          return require("refactoring").refactor "Inline Function"
        end,
        expr = true,
        desc = "Inline Function",
        mode = { "n", "x" },
      },
      {
        "<leader>ri",
        function()
          return require("refactoring").refactor "Inline Variable"
        end,
        expr = true,
        desc = "Inline Variable",
        mode = { "n", "x" },
      },
      {
        "<leader>rbb",
        function()
          return require("refactoring").refactor "Extract Block"
        end,
        expr = true,
        desc = "Extract Block",
        mode = { "n", "x" },
      },
      {
        "<leader>rbf",
        function()
          return require("refactoring").refactor "Extract Block To File"
        end,
        expr = true,
        desc = "Extract Block To File",
        mode = { "n", "x" },
      },
    },
  },
}

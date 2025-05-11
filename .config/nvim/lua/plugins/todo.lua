return {
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    keys = {
      { "<Leader>ft", vim.cmd.TodoTelescope, desc = "Find TODOs" },
    },
  },
}

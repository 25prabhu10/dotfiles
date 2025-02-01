return {
  {
    "stevearc/oil.nvim",
    config = function()
      ---@module 'oil'
      ---@type oil.setupOpts
      require("oil").setup {
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
}

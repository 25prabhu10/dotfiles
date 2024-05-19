return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        -- columns = { "icon" },
        keymaps = {
          ["<C-p>"] = false,
          ["<M-p>"] = "actions.preview",
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
  },
}

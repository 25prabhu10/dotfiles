return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.setupOpts
    opts = {
      keymaps = {
        ["<C-p>"] = false,
        ["<M-p>"] = "actions.preview",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory",
      },
    },
    lazy = false,
  },
}

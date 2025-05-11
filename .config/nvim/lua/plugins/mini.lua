return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    -- keys = {
    --   {
    --     "-",
    --     function()
    --       local bufname = vim.api.nvim_buf_get_name(0)
    --       local path = vim.fn.fnamemodify(bufname, ":p")
    --
    --       -- Noop if the buffer isn't valid.
    --       if path and vim.uv.fs_stat(path) then
    --         require("mini.files").open(bufname, false)
    --       end
    --     end,
    --     desc = "File explorer",
    --   },
    -- },
    config = function()
      local mini_icons = require "mini.icons"
      mini_icons.setup {}

      local mini_diff = require "mini.diff"
      mini_diff.setup {
        view = {
          -- Signs used for hunks with 'sign' view
          signs = { add = "+", change = "~", delete = "_" },
        },
      }

      -- local mini_files = require "mini.files"
      -- mini_files.setup {
      --   windows = {
      --     preview = true,
      --   },
      --   mappings = {
      --     go_in_plus = "<cr>",
      --   },
      -- }

      local mini_git = require "mini.git"
      mini_git.setup {}

      local mini_status_line = require "mini.statusline"
      mini_status_line.setup {}
    end,
  },
}

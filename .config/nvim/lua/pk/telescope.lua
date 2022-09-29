local M = {}

function M.setup()
  -- local actions = require "telescope.actions"

  require("telescope").setup {
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          --["<C-h>"] = "which_key"
          ["<C-k>"] = require("telescope.actions").cycle_history_next,
          ["<C-j>"] = require("telescope.actions").cycle_history_prev,
        },
      },

      history = {
        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
        limit = 100,
      },
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
  }

  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require("telescope").load_extension "fzf"

  --require("telescope").load_extension "notify" -- https://github.com/rcarriga/nvim-notify
  --require('telescope').load_extension('frecency')
end

return M

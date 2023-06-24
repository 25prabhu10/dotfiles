local M = {}

function M.setup()
  local actions = require "telescope.actions"

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
          ["<Esc>"] = actions.close,
          ["<C-k>"] = actions.cycle_history_next,
          ["<C-j>"] = actions.cycle_history_prev,
        },
      },

      history = {
        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
        limit = 100,
      },

      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    pickers = {
      find_files = { find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" } },
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    },
  }

  -- Enable telescope fzf native, if installed
  pcall(require("telescope").load_extension, "fzf")

  --require("telescope").load_extension "notify" -- https://github.com/rcarriga/nvim-notify
  -- require("telescope").load_extension "frecency"

  -- Files
  vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files, { desc = "[f]earch [f]iles" })
  vim.keymap.set("n", "<Leader>fo", require("telescope.builtin").oldfiles, { desc = "[f]ind recently [o]pened files" })
  vim.keymap.set("n", "<Leader>fb", require("telescope.builtin").buffers, { desc = "[f]ind existing [b]uffers" })
  vim.keymap.set("n", "<Leader>fw", require("telescope.builtin").live_grep, { desc = "[f]ind [w]ord by grep" })
  vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[f]ind [d]iagnostics" })
  vim.keymap.set("n", "<Leader>fm", require("telescope.builtin").man_pages, { desc = "[f]ind [m]an pages" })
  vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = "[/] Fuzzily search in current buffer" })

  -- Git
  -- vim.keymap.set("n", "<Leader>gs", "<cmd>Telescope git_status<cr>", { desc = "[f]ind [m]an pages" })
  -- vim.keymap.set("n", "<Leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "[f]ind [m]an pages" })

  -- Vim Options
  -- vim.keymap.set("n", "<Leader>bo", require("telescope.builtin").vim_options, { desc = "[f]ind [m]an pages" })
end

return M

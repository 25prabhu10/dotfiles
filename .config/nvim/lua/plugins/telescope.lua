return {
  -- fuzzy finder
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  keys = {},
  config = function()
    require("telescope").setup {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
          },
          width = 0.8,
          height = 0.8,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- add this value
        },
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            --["<C-h>"] = "which_key"
            ["<C-k>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
        path_display = { "truncate" },
        -- file_ignore_patterns = { "node_modules" },
      },
      file_previewer = require("telescope.previewers").cat.new,
      grep_previewer = require("telescope.previewers").vimgrep.new,
      qflist_previewer = require("telescope.previewers").qflist.new,
      pickers = {
        find_files = {
          prompt_prefix = "🔍",
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--color",
            "never",
            "--strip-cwd-prefix",
            "--exclude",
            ".git",
          },
          -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          -- previewer = false,
          -- fzf_separator = "|>",
          -- winblend = 10,
          -- shorten_path = false,
          results_title = false,
          preview_title = false,
          layout_config = {
            preview_width = 0.5,
          },
        },
        git_status = {
          prompt_prefix = "󰊢  ",
          show_untracked = true,
          initial_mode = "normal",
        },
        git_commits = {
          prompt_prefix = "󰊢  ",
          initial_mode = "normal",
          results_title = "git log (current buffer)",
        },
        git_branches = {
          prompt_prefix = "󰊢  ",
          initial_mode = "normal",
        },
        buffers = {
          sort_lastused = true,
          sort_mru = true,
          -- theme = "dropdown",
        },
      },
      extensions = {
        fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require "telescope.builtin"
    -- Files
    vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<Leader>fo", builtin.oldfiles, { desc = "Find recently opened files" })
    vim.keymap.set("n", "<Leader><Space>", builtin.buffers, { desc = "Find current buffers" })

    -- Git
    vim.keymap.set("n", "<Leader>ggs", function()
      if require("util").check_git_workspace() then
        builtin.git_status()
      end
    end, { desc = "Git Status" })
    vim.keymap.set("n", "<Leader>ggc", function()
      if require("util").check_git_workspace() then
        builtin.git_commits()
      end
    end, { desc = "Git Commits" })
    vim.keymap.set("n", "<Leader>ggb", function()
      if require("util").check_git_workspace() then
        builtin.git_branches()
      end
    end, { desc = "Git Branches" })
    vim.keymap.set("n", "<Leader>ggf", function()
      if require("util").check_git_workspace() then
        builtin.git_files()
      end
    end, { desc = "Find Git tracked Files" })

    -- Find words
    vim.keymap.set("n", "<Leader>/", builtin.live_grep, { desc = "Find word" })
    vim.keymap.set("n", "<Leader>fw", builtin.grep_string, { desc = "Find word under the cursor" })
    vim.keymap.set("n", "<Leader>f/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown { winblend = 10, previewer = false })
    end, { desc = "Find word under the cursor" })
    vim.keymap.set("n", "<Leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })

    -- LSP
    vim.keymap.set("n", "<Leader>gr", builtin.lsp_references, { desc = "Goto references" })
    vim.keymap.set("n", "<Leader>gd", builtin.lsp_definitions, { desc = "Goto definition" })
    vim.keymap.set("n", "<Leader>gD", builtin.lsp_type_definitions, { desc = "Goto declaration" })
    vim.keymap.set("n", "<Leader>gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
    vim.keymap.set("n", "<Leader>ds", builtin.lsp_document_symbols, { desc = "Document symbols" })
    vim.keymap.set("n", "<Leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace symbols" })
    vim.keymap.set("n", "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Search document diagnostics" })
    vim.keymap.set("n", "<Leader>sD", builtin.diagnostics, { desc = "Search workspace Diagnostics" })

    -- Others
    vim.keymap.set("n", "<Leader>so", builtin.vim_options, { desc = "Search vim options" })
    vim.keymap.set("n", "<Leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<Leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<Leader>sk", builtin.keymaps, { desc = "Search key maps" })
    vim.keymap.set("n", "<Leader>sm", builtin.man_pages, { desc = "Search in man pages" })
    vim.keymap.set("n", "<Leader>s:", builtin.command_history, { desc = "Command history" })
    -- Shortcut for searching your neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "[S]earch [N]eovim files" })
  end,
}

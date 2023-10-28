return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Files
      { "<C-p>", "<Cmd>Telescope find_files<CR>", desc = "[f]ind [f]iles" },
      {
        "<Leader>fo",
        "<Cmd>Telescope oldfiles include_current_session=false<CR>",
        desc = "[f]ind recently [o]pened files",
      },
      { "<Leader>fb", "<Cmd>Telescope buffers show_all_buffers=true<CR>", desc = "[f]ind [b]uffers" },

      -- Git
      {
        "<Leader>ggs",
        function()
          if require("util").check_git_workspace() then
            require("telescope.builtin").git_status()
          end
        end,
        desc = "Git Status",
      },
      {
        "<Leader>ggc",
        function()
          if require("util").check_git_workspace() then
            require("telescope.builtin").git_commits()
          end
        end,
        desc = "Git Commits",
      },
      {
        "<Leader>ggb",
        function()
          if require("util").check_git_workspace() then
            require("telescope.builtin").git_branches()
          end
        end,
        desc = "Git Branches",
      },
      {
        "<Leader>ggf",
        function()
          if require("util").check_git_workspace() then
            require("telescope.builtin").git_files()
          end
        end,
        desc = "Find Git tracked Files",
      },
      -- end
      -- Find words
      { "<Leader>/", "<Cmd>Telescope live_grep<CR>", desc = "Find word" },
      { "<Leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "[f]ind current [w]ord" },

      -- LSP
      { "<Leader>gr", "<Cmd>Telescope lsp_references<CR>", desc = "[g]oto [r]eferences" },
      { "<Leader>gd", "<Cmd>Telescope definition<CR>", desc = "[g]oto [d]efinition" },
      { "<Leader>gD", "<Cmd>Telescope declaration<CR>", desc = "[g]oto [d]eclaration" },
      { "<Leader>gI", "<Cmd>Telescope implementation<CR>", desc = "[g]oto [I]mplementation" },
      { "<Leader>gt", "<Cmd>Telescope type_definition<CR>", desc = "[g]oto [t]ype definition" },
      { "<Leader>ds", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "[d]ocument [s]ymbols" },
      { "<Leader>ws", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "[w]orkspace [s]ymbols" },
      { "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "[s]earch [d]ocument diagnostics" },
      { "<Leader>sD", "<Cmd>Telescope diagnostics<CR>", desc = "[s]earch workspace [D]iagnostics" },

      -- Others
      { "<Leader>so", "<Cmd>Telescope vim_options<CR>", desc = "[s]earch vim [o]ptions" },
      { "<Leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "[s]earch [k]ey maps" },
      { "<Leader>sm", "<Cmd>Telescope man_pages<CR>", desc = "[s]earch in [m]an pages" },
      { "<Leader>:", "<Cmd>Telescope command_history<CR>", desc = "Command history" },
    },
    config = function()
      require("telescope").setup {
        defaults = {
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
        },
      }

      _ = pcall(require("telescope").load_extension, "fzf")
    end,
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
  },
}

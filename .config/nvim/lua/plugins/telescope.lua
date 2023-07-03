return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    commit = vim.fn.has "nvim-0.9.0" == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
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
        --file_ignore_patterns = { "node_modules" },
      },
      pickers = {
        find_files = {
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
          --find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        --live_grep = {
        --previewer = false,
        --fzf_separator = "|>",
        --winblend = 10,
        --shorten_path = false,
        --},
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
      },
      extensions = {
        fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
      },
    },
    keys = {
      -- Files
      { "<Leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find Files" },
      {
        "<Leader>fo",
        "<Cmd>Telescope oldfiles include_current_session=false<CR>",
        desc = "[f]ind recently [o]pened files",
      },
      { "<Leader>fb", "<Cmd>Telescope buffers show_all_buffers=true<CR>", desc = "[f]ind [b]uffers" },

      -- Find words
      { "<Leader>/", "<Cmd>Telescope live_grep<CR>", desc = "Find word" },
      { "<Leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "[f]ind current [w]ord" },

      -- Git
      { "<Leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "[g]it [c]ommits" },
      { "<Leader>gs", "<Cmd>Telescope git_status<CR>", desc = "[g]it [s]tatus" },
      { "<Leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "[g]it [b]ranches" },
      { "<C-p>", "<Cmd>Telescope git_files<CR>", desc = "Find Git tracked files" },

      -- LSP
      { "<Leader>gr", "<Cmd>Telescope lsp_references<CR>", desc = "[g]oto [r]eferences" },
      { "<Leader>gd", "<Cmd>Telescope definition<CR>", desc = "[g]oto [d]efinition" },
      { "<Leader>gD", "<Cmd>Telescope declaration<CR>", desc = "[g]oto [d]eclaration" },
      { "<Leader>gI", "<Cmd>Telescope implementation<CR>", desc = "[g]oto [I]mplementation" },
      { "<Leader>gt", "<Cmd>Telescope type_definition<CR>", desc = "[g]oto [t]ype definition" },
      { "<Leader>ds", "<Cmd>Telescope lsp_document_symbols", desc = "[d]ocument [s]ymbols" },
      { "<Leader>ws", "<Cmd>Telescope lsp_dynamic_workspace_symbols", desc = "[w]orkspace [s]ymbols" },
      { "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "[s]earch [d]ocument diagnostics" },
      { "<Leader>sD", "<Cmd>Telescope diagnostics<CR>", desc = "[s]earch Workspace [D]iagnostics" },

      -- Others
      { "<Leader>so", "<Cmd>Telescope vim_options<CR>", desc = "[s]earch Vim [o]ptions" },
      { "<Leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "[s]earch [k]ey Maps" },
      { "<Leader>sm", "<Cmd>Telescope man_pages<CR>", desc = "[s]earch in [m]an Pages" },
      { "<Leader>:", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
    },
  },
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
    config = function()
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}

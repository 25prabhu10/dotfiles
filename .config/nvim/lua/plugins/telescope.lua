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
          find_command = { "fd", "--type", "f", "--hidden", "--color", "never", "--strip-cwd-prefix", "--exclude", ".git" },
          --find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        --live_grep = {
        --previewer = false,
        --fzf_separator = "|>",
        --winblend = 10,
        --shorten_path = false,
        --},
      },
      extensions = {
        fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
      },
    },
    keys = {
      -- Files
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
      { "<leader>fo", "<cmd>Telescope oldfiles include_current_session=false<cr>", desc = "[F]ind recently [o]pened files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind existing [b]uffers" },
      { "<leader>fB", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },

      -- Find words
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word (root dir)" },

      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Word (root dir)" },

      -- LSP
      { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "[G]oto [R]eferences" },
      { "<leader>gd", "<cmd>Telescope definition<cr>", desc = "[G]oto [D]efinition" },
      { "<leader>gD", "<cmd>Telescope declaration<cr>", desc = "[G]oto [D]eclaration" },
      { "<leader>gI", "<cmd>Telescope implementation<cr>", desc = "[G]oto [I]mplementation" },
      { "<leader>gt", "<cmd>Telescope type_definition<cr>", desc = "[G]oto [T]ype Definition" },
      { "<leader>ds", "<cmd>Telescope lsp_document_symbols", desc = "[D]ocument [S]ymbols" },
      { "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols", desc = "[W]orkspace [S]ymbols" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },

      -- Others
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "[S]earch in [M]an Pages" },
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

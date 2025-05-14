return {
  -- fuzzy finder
  "nvim-telescope/telescope.nvim",
  --branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
    -- { "nvim-telescope/telescope-smart-history.nvim" },
  },
  config = function()
    local telescopeConfig = require "telescope.config"

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    -- Trim the indentation at the beginning of presented line
    table.insert(vimgrep_arguments, "--trim")

    require("telescope").setup {
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        path_display = { "truncate" },
        dynamic_preview_title = true,
      },
      pickers = {
        find_files = {
          theme = "ivy",
          find_command = {
            "fd",
            "--type",
            "f",
            "--strip-cwd-prefix",
            "--hidden",
            "--color",
            "never",
            "--follow",
            "--exclude",
            ".git",
          },
        },
        help_tags = {
          theme = "ivy",
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
    local map = require("config.local-lib").map

    -- Files
    map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
    map("n", "<Leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ldfiles" })
    map("n", "<Leader><Space>", builtin.buffers, { desc = "[F]ind [B]uffers" })

    -- Text
    map("n", "<Leader>/", builtin.live_grep, { desc = "Find word" })
    map("n", "<Leader>fw", builtin.grep_string, { desc = "Find word under the cursor" })
    map("n", "<Leader>f/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown { winblend = 10, previewer = false })
    end, { desc = "Find in current file" })
    map("n", "<Leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })

    -- Git
    map("n", "<Leader>ggs", function()
      if require("config.local-lib").check_git_workspace() then
        builtin.git_status()
      end
    end, { desc = "[G]it [S]tatus" })
    map("n", "<Leader>ggc", function()
      if require("config.local-lib").check_git_workspace() then
        builtin.git_commits()
      end
    end, { desc = "[G]it [C]ommits" })
    map("n", "<Leader>ggb", function()
      if require("config.local-lib").check_git_workspace() then
        builtin.git_branches()
      end
    end, { desc = "[G]it [B]ranches" })
    map("n", "<Leader>ggf", function()
      if require("config.local-lib").check_git_workspace() then
        builtin.git_files()
      end
    end, { desc = "[G]it [F]iles" })

    -- LSP
    map("n", "<Leader>gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
    map("n", "<Leader>gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
    map("n", "<Leader>gD", builtin.lsp_type_definitions, { desc = "[G]oto Type [D]eclaration" })
    map("n", "<Leader>gI", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
    map("n", "<Leader>fs", builtin.lsp_document_symbols, { desc = "[F]ind Document [S]ymbols" })
    map("n", "<Leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
    map("n", "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", { desc = "[D]ocument [D]iagnostics" })
    map("n", "<Leader>sD", builtin.diagnostics, { desc = "[W]orkspace [D]iagnostics" })

    -- Others
    map("n", "<Leader>so", builtin.vim_options, { desc = "[S]earch Vim [O]ptions" })
    map("n", "<Leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    map("n", "<Leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    map("n", "<Leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    map("n", "<Leader>sm", builtin.man_pages, { desc = "[S]earch [M]anpages" })
    map("n", "<Leader>s:", builtin.command_history, { desc = "Command history" })

    -- Shortcut for searching your Neovim configuration files
    map("n", "<leader>sn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "[S]earch [N]eovim files" })
  end,
}

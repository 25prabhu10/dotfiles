local M = {}

local PACKER_BOOTSTRAP = false

local function packer_init()
  -- Automatically install packer
  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    }

    print "Installing packer, close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
  end
  -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
end

packer_init()

function M.setup()
  -- Have packer use a popup window
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  local function plugins(use)
    -- Improve startup time
    use {
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient").enable_profile()
      end,
    }

    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Undo Helper: File History
    use {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      opt = true,
      config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
    }

    -- Nvim-Tree: file explorer & File icons
    use {
      "nvim-tree/nvim-tree.lua",
      event = "BufWinEnter",
      opt = true,
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-web-devicons").setup { default = true }
        require("pk.nvim-tree").setup()
      end,
    }

    -- Buffers
    -- use {
    --   "akinsho/bufferline.nvim",
    --   tag = "v2.*",
    --   event = "BufReadPre",
    --   opt = true,
    --   config = function()
    --     require("pk.bufferline").setup()
    --   end,
    -- }

    -- Status Line
    use {
      "nvim-lualine/lualine.nvim",
      after = "nvim-treesitter",
      config = function()
        require("pk.lualine").setup()
      end,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      as = "nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
      },
      config = function()
        require("pk.treesitter").setup()
      end,
    }

    -- Additional text objects via treesitter
    -- use {
    --   "nvim-treesitter/nvim-treesitter-textobjects",
    --   after = "nvim-treesitter",
    -- }

    -- LSP Config
    use {
      "neovim/nvim-lspconfig",
      after = "nvim-treesitter",
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        "j-hui/fidget.nvim",

        -- Additional lua configuration, makes nvim stuff amazing
        -- "folke/neodev.nvim",
      },
      config = function()
        require("pk.lsp").setup()
      end,
    }

    -- Auto Complete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
        --"ray-x/cmp-treesitter",
      },
      config = function()
        require("pk.cmp").setup()
      end,
    }

    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Comments
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      opt = true,
      config = function()
        require("Comment").setup()
      end,
    }

    -- Telescope 🔭
    use {
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("pk.telescope").setup()
      end,
    }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built
    -- Only load if `make` is available
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    }

    -- For formatters and linters
    use "jose-elias-alvarez/null-ls.nvim"

    -- Git related plugins
    -- use 'tpope/vim-fugitive'
    -- use 'tpope/vim-rhubarb'
    -- use {
    --   "lewis6991/gitsigns.nvim",
    --   config = function()
    --     require("gitsigns").setup {
    --       signs = {
    --         add = { text = "+" },
    --         change = { text = "~" },
    --         delete = { text = "_" },
    --         topdelete = { text = "‾" },
    --         changedelete = { text = "~" },
    --       },
    --     }
    --   end,
    -- }

    -- Colorschemes
    -- use "EdenEast/nightfox.nvim"
    -- use "sam4llis/nvim-tundra"
    -- use "ayu-theme/ayu-vim"
    -- use "folke/tokyonight.nvim"
    use "rebelot/kanagawa.nvim"

    -- CSS Colors
    use {
      "norcalli/nvim-colorizer.lua",
      opt = true,
      ft = { "css", "scss", "javascript" },
      config = function()
        require("pk.colorizer").setup()
      end,
    }

    -- Little know features:
    --   :SSave
    --   :SLoad
    --       These are wrappers for mksession that work great. I never have to use
    --       mksession anymore or worry about where things are saved / loaded from.
    --use {
    --"mhinz/vim-startify",
    --cmd = { "SLoad", "SSave" },
    --config = function()
    --vim.g.startify_disable_at_vimenter = true
    --end,
    --}

    -- Pretty colors
    --use "norcalli/nvim-colorizer.lua"
    --use {
    --"norcalli/nvim-terminal.lua",
    --config = function()
    --require("terminal").setup()
    --end,
    --}

    --   FOCUSING:
    --local use_folke = true
    --if use_folke then
    --use "folke/zen-mode.nvim"
    --use "folke/twilight.nvim"
    --else
    --use {
    --"junegunn/goyo.vim",
    --cmd = "Goyo",
    --disable = use_folke,
    --}

    --use {
    --"junegunn/limelight.vim",
    --after = "goyo.vim",
    --disable = use_folke,
    --}
    --end

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
      print "=================================="
      print "    Plugins are being installed"
      print "    Wait until Packer completes,"
      print "       then restart nvim"
      print "=================================="
      require("packer").sync()
    end
  end

  pcall(require, "impatient")
  pcall(require, "packer_compiled")
  require("packer").init(conf)
  require("packer").startup(plugins)
end

return M

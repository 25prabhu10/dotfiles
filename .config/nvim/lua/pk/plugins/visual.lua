return {
  -- {
  --   -- Set lualine as statusline
  --   "nvim-lualine/lualine.nvim",
  --   -- See `:help lualine.txt`
  --   event = "VeryLazy",
  --   opts = {
  --     options = {
  --       -- Disable sections and component separators
  --       globalstatus = true,
  --       disabled_filetypes = {
  --         statusline = { "alpha", "lazy", "fugitive" },
  --         winbar = { "alpha", "help", "lazy" },
  --       },
  --     },
  --     icons_enabled = true,
  --     -- theme = "catppuccin",
  --     component_separators = "|",
  --     section_separators = "",
  --   },
  -- },
  {
    "echasnovski/mini.statusline",
    opts = {},
    config = function()
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require "mini.statusline"
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = true }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- See `:help ibl`
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "|" },
      exclude = {
        filetypes = {
          "alpha",
          "dashboard",
          "lazy",
          "lazyterm",
          "mason",
          "notify",
          "nvim-tree",
          "toggleterm",
          "Trouble",
        },
      },
    },
  },
  -- Zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    dependencies = {
      "folke/twilight.nvim",
    },
    opt = {
      window = {
        backdrop = 1,
        height = 0.9,
        width = 140,
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          cursorline = false, -- disbale cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      plugins = {
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting `laststatus`
          -- statusline will be shown only if `laststatus === 3`
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        alacritty = {
          enabled = true,
          font = "8", -- font size
        },
      },
    },
    keys = { { "<Leader>z", vim.cmd.ZenMode, desc = "Toggle Zen Mode" } },
  },
}

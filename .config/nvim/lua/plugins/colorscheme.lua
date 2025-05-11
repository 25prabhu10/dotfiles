return {
  -- { "morhetz/gruvbox" },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = { transparent_mode = true } },

  --{ "rose-pine/neovim", name = "rose-pine", lazy = true },

  -- Theme inspired by Atom
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = true,
  --   config = function()
  --     vim.cmd.colorscheme "onedark"
  --   end,
  -- },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   init = function()
  --     -- Load the colorscheme here
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'
  --     -- vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like
  --     vim.cmd.hi "Comment gui=none"
  --   end,
  --   opts = { style = "night" },
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = true,
  -- },

  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   priority = 1000,
  --   name = "catppuccin",
  --   opts = {
  --     transparent_background = true,
  --     flavour = "mocha", -- latte, frappe, macchiato, mocha
  --     -- dim_inactive = {
  --     --   enable = true, -- dims the background color of inactive window
  --     --   shade = "dark",
  --     --   percentage = 0.15, -- percentage of the shade to apply to the inactive window
  --     -- },
  --     integrations = {
  --       -- alpha = true,
  --       -- cmp = true,
  --       -- fidget = false,
  --       -- gitsigns = true,
  --       -- harpoon = false,
  --       -- indent_blankline = { enabled = true },
  --       -- lsp_trouble = true,
  --       --mason = true,
  --       -- native_lsp = {
  --       --   enabled = true,
  --       --   underlines = {
  --       --     errors = { "undercurl" },
  --       --     hints = { "undercurl" },
  --       --     warnings = { "undercurl" },
  --       --     information = { "undercurl" },
  --       --   },
  --       -- },
  --       -- navic = { enabled = true },
  --       -- neotest = true,
  --       -- noice = true,
  --       -- notify = true,
  --       -- nvimtree = true,
  --       -- semantic_tokens = true,
  --       telescope = { enabled = true, style = "nvchad" },
  --       -- treesitter = true,
  --       -- which_key = true,
  --     },
  --   },
  -- },
}

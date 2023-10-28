return {
  -- gruvbox
  -- { "morhetz/gruvbox" },
  -- { "ellisonleao/gruvbox.nvim", lazy = true, config = true },

  -- { "rose-pine/neovim", name = "rose-pine", lazy = true },

  -- Theme inspired by Atom
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = true,
  --   config = function()
  --     vim.cmd.colorscheme "onedark"
  --   end,
  -- },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        nvimtree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}

return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- Library used by other {ins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- To surround and fix repeat
  -- GOAT tpope
  { "tpope/vim-surround" },
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- Undo manager
  { "mbbill/undotree", event = { "BufReadPost", "BufNewFile" }, cmd = "UndtreeToggle" },
}

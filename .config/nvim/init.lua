-------------------------------------------------------------------------------
-- Author: Prabhu K H
-- Repo: https://github.com/25prabhu10/dotfiles
-------------------------------------------------------------------------------

require "config.options"
require "config.keymaps"
require "config.autocmds"
require "config.usercmds"

-- Plugin manager
require "config.lazy"

vim.cmd.colorscheme "tokyonight" -- Set colour scheme

--local status, _ = pcall(vim.cmd, "colorscheme vimasd")
--if not status then
--print("Colorscheme not found!")
--return
--end

-- TODO: Checkout plugins
-- "Eandrju/cellular-automaton.nvim"
-- "norcalli/nvim-colorizer.lua"
-- "numToStr/Comment.nvim"
-- "sindrets/diffview.nvim"
-- "godlygeek/tabular"
-- "simrat39/inlay-hints.nvim"
-- "folke/zen-mode.nvim"
-- "folke/twilight.nvim"
-- "nvim-treesitter/nvim-treesitter-context"
-- "mattn/emmet-vim"
-- "ThePrimeagen/refactoring.nvim"

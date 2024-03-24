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

-- Function that checks if colour scheme exists and sets it
local function set_color_scheme(name)
  local status, _ = pcall(function()
    vim.cmd("colorscheme " .. name)
  end)
  if not status then
    vim.notify_once("Color Scheme `" .. name .. "` not found", vim.log.levels.ERROR)
  end
end

set_color_scheme "catppuccin"

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

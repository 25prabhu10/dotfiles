-------------------------------------------------------------------------------
-- Author: Prabhu K H
-- Repo: https://github.com/25prabhu10/dotfiles
-------------------------------------------------------------------------------

-- Remap leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

--[[
-- Setup initial configuration,
-- 
-- Primarily just download and execute lazy.nvim
--]]
-- Install plugin manager and load configs
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/pk/plugins/` folder
require("lazy").setup({ import = "pk/plugins" }, {
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        -- "bugreport",
        -- "editorconfig",
        -- "ftplugin",
        -- "compiler",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "matchparen",
        "rplugin",
        "rrhelper",
        -- "spellfile_plugin",
        -- "synmenu",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
  },
})

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

-- Disable builtin vim
--vim.g.loaded_gzip = 1
--vim.g.loaded_zip = 1
--vim.g.loaded_zipPlugin = 1
--vim.g.loaded_tar = 1
--vim.g.loaded_tarPlugin = 1

--vim.g.loaded_getscript = 1
--vim.g.loaded_getscriptPlugin = 1
--vim.g.loaded_vimball = 1
--vim.g.loaded_vimballPlugin = 1
--vim.g.loaded_2html_plugin = 1

--vim.g.loaded_matchit = 1
--vim.g.loaded_matchparen = 1
--vim.g.loaded_logiPat = 1
--vim.g.loaded_rrhelper = 1

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
--vim.g.loaded_netrwSettings = 1

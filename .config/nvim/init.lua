-------------------------------------------------------------------------------
-- Author: Prabhu K H
-- Repo: https://github.com/25prabhu10/dotfiles
-------------------------------------------------------------------------------

-- Remap leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim
require "config.lazy"

-- Function that checks if colour scheme exists and sets it
vim.cmd "colorscheme gruvbox"

-- Install plugins
-- "rest-nvim/rest.nvim", -- HTTP client
-- "sindrets/diffview.nvim" -- diff view of git changes
-- "numToStr/Comment.nvim" -- comment/uncomment lines
-- "Eandrju/cellular-automaton.nvim" -- cellular automaton animation
-- "echasnovski/mini.align" -- alignment of text (lua)
-- "junegunn/vim-easy-align" -- alignment of text (vim)

-- -- keymap.lua file
-- local M = {}
--
-- local function bind(op, outer_opts)
--   outer_opts = outer_opts or { noremap = true }
--   return function(lhs, rhs, opts)
--     opts = vim.tbl_extend("force", outer_opts, opts or {})
--     vim.keymap.set(op, lhs, rhs, opts)
--   end
-- end
--
-- M.nmap = bind("n", { noremap = false })
-- M.nnoremap = bind "n" -- normal noremap
-- M.vnoremap = bind "v"
-- M.xnoremap = bind "x"
-- M.inoremap = bind "i"
--
-- return M

-- --repam.lua file
-- local nnoremap = require("pk.keymap").nnoremap
--
-- -- Open netrw
-- nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- Local vars
local opts = { noremap = true, silent = true }

-- Remap leader key
-- vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Map kj to esc in insert mode
vim.keymap.set("i", "kj", "<Esc>", opts)

-- Cursor movement when word wrap is on
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "j", "gj", opts)

-- Move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Shortcut to save
vim.keymap.set("n", "<C-s>", "<cmd>update<CR>", opts)

-- Spelling Check
vim.keymap.set("n", "<F8>", function()
  --local isSpellOn = if vim.inspect(vim.opt.spell._value) then "on" else "off" end
  print("Spell is " .. tostring(vim.inspect(vim.opt.spell._value)))
  return "<cmd>set spell!<CR>"
end, { noremap = true, silent = true, expr = true })

-- Close current buffer
vim.keymap.set("n", "<Leader>q", "<cmd>bd<CR>", opts)

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', opts)

-- Make "Y" yank behave like other capital letters do
vim.keymap.set("n", "Y", "yg_", opts)

-- Yank to clipboard
vim.keymap.set("n", "<Leader>y", '"+y', opts)
vim.keymap.set("v", "<Leader>y", '"+y', opts)
vim.keymap.set("n", "<Leader>Y", '"+Yg_')

-- Paste from clipboard
vim.keymap.set("n", "<Leader>p", '"+p', opts)
vim.keymap.set("n", "<Leader>P", '"+P')
-- vim.keymap.set("x", "<Leader>p", '"_dP', opts)

-- Delete without yank
vim.keymap.set("n", "<Leader>d", '"_d', opts)
vim.keymap.set("v", "<Leader>d", '"_d', opts)
vim.keymap.set("n", "x", '"_x', opts)

-- Spell bindings
-- "nnoremap <Leader>sn ]s
-- "nnoremap <Leader>sp [s
-- "nnoremap <Leader>sa zg
-- "nnoremap <Leader>s? z=

-- Navigate around splits
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
--vim.keymap.set("n", "<C-j>", "<C-w>j")
--vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Clear search highlights
vim.keymap.set("n", "<Leader><Leader>", "<cmd>let @/=''<CR>", opts)

-- Increase and decrease split width
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)

-- TAB in general mode will move to text buffer
vim.keymap.set("n", "<Leader><TAB>", "<cmd>bnext<CR>", opts)
vim.keymap.set("n", "<Leader><S-TAB>", "<cmd>bprevious<CR>", opts)

-- GOTO next or previous local errors in local list
-- nnoremap <Leader>j <cmd>lnext<CR>zz
-- nnoremap <Leader>k <cmd>lprev<CR>zz

-- Join lines and place cursor back to original place
-- vim.keymap.set("n", "J", "mzJ`z", opts)

-- Page Scroll
vim.keymap.set("n", "<C-j>", "3<C-e>", opts)
vim.keymap.set("n", "<C-k>", "3<C-y>", opts)

-- Page up and down centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Keep search text centered
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Add new line below and above current line
vim.keymap.set("n", "<Leader>o", "o<Esc>j", opts)
vim.keymap.set("n", "<Leader>O", "O<Esc>j", opts)

-- qq to record, Q to replay
vim.keymap.set("n", "Q", "@q")

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>", opts)
vim.keymap.set("n", "-", "<C-x>", opts)

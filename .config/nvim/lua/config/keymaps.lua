-- Remap leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Local function
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Map kj to esc in insert mode
map("i", "kj", "<Esc>", { desc = "Escape!!!" })

-- Cursor movement when word wrap is on
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- Make "Y" yank behave like other capital letters do
map("n", "Y", "yg_")

-- Yank to clipboard
map("n", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<Leader>Y", '"+Yg_', { desc = "Copy to system clipboard" })

-- Paste from clipboard
map("n", "<Leader>p", '"+p', { desc = "Paste to system clipboard" })
map("n", "<Leader>P", '"+P', { desc = "Paste to system clipboard" })
-- map("x", "<Leader>p", '"_dP', {desc =""})

-- Delete without yank
map("n", "<Leader>d", '"_d', { desc = "Delete without yank" })
map("v", "<Leader>d", '"_d', { desc = "Delete without yank" })
map("n", "x", '"_x')

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
--map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys (respecting `v:count`)
map("n", "<C-Up>", '"<cmd>resize +" . v:count1 . "<cr>"', { expr = true, replace_keycodes = false, desc = "Increase window height" })
map("n", "<C-Down>", '"<cmd>resize -" . v:count1 . "<cr>"', { expr = true, replace_keycodes = false, desc = "Decrease window height" })
map("n", "<C-Left>", '"<cmd>vertical resize -" . v:count1 . "<cr>"', { expr = true, replace_keycodes = false, desc = "Decrease window width" })
map("n", "<C-Right>", '"<cmd>vertical resize +" . v:count1 . "<cr>"', { expr = true, replace_keycodes = false, desc = "Increase window width" })

-- Close current buffer
map("n", "<Leader>q", "<cmd>bd<CR>", { desc = "Close current buffer" })

-- Navigate buffers
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- GOTO next or previous local errors in local list
-- nnoremap <Leader>j <cmd>lnext<CR>zz
-- nnoremap <Leader>k <cmd>lprev<CR>zz

-- Join lines and place cursor back to original place
-- map("n", "J", "mzJ`z", {desc =""})

-- Page Scroll
map("n", "<C-e>", "3<C-e>", { desc = "Scroll down" })
map("n", "<C-y>", "3<C-y>", { desc = "Scroll up" })

-- Page up and down centered
map("n", "<C-d>", "<C-d>zz", { desc = "Page up" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page down" })

-- Keep search text centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
--map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add new line below and above current line
map("n", "<Leader>o", "o<Esc>j", { desc = "Add an empty line above" })
map("n", "<Leader>O", "O<Esc>j", { desc = "Add an empty line below" })

-- `qq` to record, `Q` to replay
map("n", "Q", "@q")

-- Open Netrw
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Netrw" })

-- Save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Spelling Check
map("n", "<Leader>us", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()

  if vim.opt_local.spell:get() then
    print "Enabled Spell Check"
  else
    print "Disabled Spell Check"
  end
end, { desc = "Toggle spell check" })

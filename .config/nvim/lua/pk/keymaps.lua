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

-- Page Scroll
vim.keymap.set("n", "<C-j>", "3<C-e>", opts)
vim.keymap.set("n", "<C-k>", "3<C-y>", opts)

-- Add new line below and above current line
vim.keymap.set("n", "<Leader>o", "o<Esc>j", opts)
vim.keymap.set("n", "<Leader>O", "O<Esc>j", opts)

-- qq to record, Q to replay
vim.keymap.set("n", "Q", "@q")

-- Make Y behave like other capital letters do
vim.keymap.set("n", "Y", "yg_", opts)

-- Keep search text centered
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>", opts)
vim.keymap.set("n", "-", "<C-x>", opts)

-- Delete without yank
vim.keymap.set("n", "<Leader>d", '"_d', opts)
vim.keymap.set("n", "x", '"_x', opts)

-- Nvim-Tree Mappings
vim.keymap.set("n", "<Leader>n", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope Mappings
-- Files
vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<Leader>fw", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<Leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("n", "<Leader>fm", "<cmd>Telescope man_pages<cr>", opts)

-- Git
vim.keymap.set("n", "<Leader>gs", "<cmd>Telescope git_status<cr>", opts)
vim.keymap.set("n", "<Leader>gc", "<cmd>Telescope git_commits<cr>", opts)

-- Vim Options
vim.keymap.set("n", "<Leader>bo", "<cmd>Telescope vim_options<cr>", opts)

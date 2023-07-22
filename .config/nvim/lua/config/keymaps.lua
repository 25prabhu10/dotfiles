-- Remap leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

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
map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move up" })
map("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Make "Y" yank behave like other capital letters do
map("n", "Y", "yg_")

-- Yank to clipboard
map("n", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<Leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<Leader>Y", '"+Yg_', { desc = "Copy to system clipboard" })

-- Paste from clipboard
map("n", "<Leader>p", '"+p', { desc = "Paste to system clipboard" })
map("n", "<Leader>P", '"+P', { desc = "Paste to system clipboard" })
map("v", "p", '"_dP', { desc = "Paste over currently selected text without yanking it" })

-- Delete without yank
map("n", "<Leader>d", '"_d', { desc = "Delete without yank" })
map("v", "<Leader>d", '"_d', { desc = "Delete without yank" })
map("n", "x", '"_x', { desc = "Delete letter without yank" })

-- Buffers
map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<LocalLeader>q", "<Cmd>bd<CR>", { desc = "Close current buffer" })

-- Navigate tabs
map("n", "<Leader><Tab>o", "<Cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<Leader><Tab>q", "<Cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<Leader><Tab>n", "<Cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<Leader><Tab>p", "<Cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys (respecting `v:count`)
map(
  "n",
  "<C-Up>",
  '"<Cmd>resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window height" }
)
map(
  "n",
  "<C-Down>",
  '"<Cmd>resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window height" }
)
map(
  "n",
  "<C-Left>",
  '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window width" }
)
map(
  "n",
  "<C-Right>",
  '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window width" }
)

-- GOTO next or previous local errors in local list
-- nnoremap <Leader>j <Cmd>lnext<CR>zz
-- nnoremap <Leader>k <Cmd>lprev<CR>zz

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

-- Add new line below and above current line
map("n", "<Leader>o", "o<Esc>j", { desc = "Add an empty line above" })
map("n", "<Leader>O", "O<Esc>j", { desc = "Add an empty line below" })

-- `qq` to record, `Q` to replay
map("n", "Q", "@q")

-- Open Netrw
map("n", "<LocalLeader>e", vim.cmd.Ex, { desc = "Open file explorer" })

-- Save file
map({ "i", "v", "n", "s" }, "<C-s>", "<Cmd>w<CR><Esc>", { desc = "Save file" })

-- Spelling Check
map("n", "<LocalLeader>s", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()

  if vim.opt_local.spell:get() then
    print "Enabled Spell Check"
  else
    print "Disabled Spell Check"
  end
end, { desc = "Toggle spell check" })

-- Change `cwd`
map("n", "<Leader>cd", "<Cmd>cd %:p:h | pwd<CR>", { desc = "Change `cwd` to currently opened directory" })

-- Execute selected lines
map("v", "<Leader>cx", "yPgv:!", { desc = "Execute selected lines" })

-- Format document
map("n", "<Leader>fd", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format current buffer with LSP" })

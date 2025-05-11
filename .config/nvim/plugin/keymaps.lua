-- Key mapping function
---
---@param mode string|string[] Mode short-name
---@param lhs string Left-hand side
---@param rhs string|function Right-hand side
---@param opts? vim.keymap.set.Opts Additional mapping options
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent or true
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  -- See `:help vim.keymap.set()`
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Keymaps for better default experience
-- NOTE: Mapping <Space> to `<Nop>` might interfere with multi-key mappings starting with `<Space>`. Neovim might wait for more input after `<Space>` is
-- pressed due to the harpoon mappings, but the initial `<Space>` itself does nothing. This could lead to unexpected behaviour or require pressing
-- `<Space>` twice. Consider removing the `<Nop>` mapping if you use the harpoon mappings frequently, or change the harpoon mappings to use a different leader
-- map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Map `kj` to `esc` in insert mode
map("i", "kj", "<Esc>", { desc = "Escape!!!" })

-- Source current file
map("n", "<LocalLeader><LocalLeader>x", "<Cmd>source %<CR>", { desc = "Source current file" })

-- Cursor movement when word wrap is on
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- `qq` to record, `Q` to replay
map("n", "Q", "@q")

-- Move Lines up and down with `Alt + j/k` (similar to VSCode)
map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Make `Y` yank behave like other capital letters do
map("n", "Y", "yg_")

-- Yank to system clipboard
map("n", "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
map("v", "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<Leader>Y", '"+Yg_', { desc = "Yank line to system clipboard" })

-- Paste from system clipboard
map("n", "<Leader>p", '"+p', { desc = "Paste from system clipboard" })
map("n", "<Leader>P", '"+P', { desc = "Paste before from system clipboard" })
map("v", "p", '"_dP', { desc = "Paste over selection (no yank)" })

-- Delete without yank
map({ "n", "v" }, "<Leader>d", '"_d', { desc = "Delete (no yank)" })
map("n", "x", '"_x', { desc = "Delete char (no yank)" })

-- Buffer navigation
map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<LocalLeader>q", "<Cmd>bd<CR>", { desc = "Close current buffer" })

-- Tab navigation
map("n", "<Leader><Tab>o", "<Cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<Leader><Tab>q", "<Cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<Leader><Tab>n", "<Cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<Leader><Tab>p", "<Cmd>tabp<CR>", { desc = "Previous tab" })

-- Move to window using the `<ctrl> hjkl` keys
-- map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize window using `<ctrl>` arrow keys (respecting `v:count`)
map("n", "<C-Up>", '"<Cmd>resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = "Increase window height" })
map("n", "<C-Down>", '"<Cmd>resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = "Decrease window height" })
map("n", "<C-Left>", '"<Cmd>vertical resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = "Decrease window width" })
map("n", "<C-Right>", '"<Cmd>vertical resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = "Increase window width" })

-- Go to next or previous local errors in local list
-- nnoremap <Leader>j <Cmd>lnext<CR>zz
-- nnoremap <Leader>k <Cmd>lprev<CR>zz

-- Join lines and place cursor back to original place
-- map("n", "J", "mzJ`z", {desc =""})

-- Page Scroll offset by 3 lines
map("n", "<C-e>", "3<C-e>", { desc = "Scroll down" })
map("n", "<C-y>", "3<C-y>", { desc = "Scroll up" })

-- Page up and down centred
map("n", "<C-d>", "<C-d>zz", { desc = "Page up (center)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page down (center)" })

-- Keep search text centred
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Add new line below and above current line
map("n", "<Leader>o", "o<Esc>j", { desc = "New line above" })
map("n", "<Leader>O", "O<Esc>j", { desc = "New line below" })

-- Open Netrw
-- map("n", "<LocalLeader>e", vim.cmd.Lexplore, { desc = "Open file explorer" })

-- Spelling Check
map("n", "<LocalLeader>s", function()
  ---@diagnostic disable-next-line
  vim.opt_local.spell = not vim.opt_local.spell:get()
  ---@diagnostic disable-next-line: param-type-mismatch, undefined-field
  print("Setting `spell` check to: " .. tostring(vim.opt_local.spell:get()))
end, { desc = "Toggle spell check" })

-- Change `cwd`
-- map("n", "<Leader>cd", "<Cmd>cd %:p:h | pwd<CR>", { desc = "Change `cwd` to currently opened directory" })

-- Execute selected lines
map("v", "<Leader>cx", "yPgv:!", { desc = "Execute selection" })

-- Exit terminal mode in the built-in terminal with a shortcut that is a bit easier
-- for people to discover, Otherwise, you normally need to press `<C-\><C-n>`, which
-- is not what someone will guess without a bit more experience
--
-- NOTE: This won't in all terminal emulators/tmux/etc. Try your can mapping
-- or just use `<C-\><C-n>` to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open a terminal at the bottom of the screen with a fixed height
map("n", "<Leader>t", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 15)
  vim.wo.winfixheight = true
end, { desc = "Open terminal (bottom)" })

-- Open diagnostics in a floating window
map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Open diagnostics in location list
map("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

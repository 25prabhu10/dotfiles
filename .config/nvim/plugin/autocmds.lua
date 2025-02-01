local function augroup(name)
  return vim.api.nvim_create_augroup("pk_" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  desc = "Highlight on yanking (copying) text",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 150,
      on_visual = false,
    }
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  desc = "Resize splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- Remove formatoptions
autocmd({ "BufWinEnter" }, {
  group = augroup "remove_format_options",
  desc = "Don't add auto comment for new string",
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup "last_loc",
  desc = "Go to the last loc when opening a buffer",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set local settings for terminal buffers
autocmd("TermOpen", {
  group = augroup "custom-term-open",
  desc = "Set local settings for terminal buffer",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})

-- Show cursor line only in active window
-- autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
--     if ok and cl then
--       vim.wo.cursorline = true
--       vim.api.nvim_win_del_var(0, "auto-cursorline")
--     end
--   end,
-- })
-- autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     local cl = vim.wo.cursorline
--     if cl then
--       vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
--       vim.wo.cursorline = false
--     end
--   end,
-- })

-- File templates
autocmd({ "BufNewFile" }, {
  group = augroup "skeleton_sh",
  pattern = "*.sh",
  command = "0r ~/.config/nvim/skeletons/bash.sh",
})

autocmd({ "BufNewFile" }, {
  group = augroup "skeleton_md",
  pattern = "*.md",
  command = "0r ~/.config/nvim/skeletons/markdown.md",
})

autocmd({ "BufNewFile" }, {
  group = augroup "skeleton_md_new",
  pattern = "*.md",
  callback = function()
    local l
    if vim.fn.line "$" > 20 then
      l = 20
    else
      l = vim.fn.line "$"
    end
    vim.fn.execute("1," .. l .. "g/date: /s/date: .*/date: " .. vim.fn.strftime "%Y-%m-%d")
    vim.fn.execute("1," .. l .. "g/title: /s/title: .*/title: " .. vim.fn.expand "%:t:r")
    vim.fn.execute("1," .. l .. "g/# /s/# .*/# " .. vim.fn.expand "%:t:r")
  end,
})

autocmd({ "BufWritePre", "FileWritePre" }, {
  group = augroup "skeleton_md_update",
  pattern = "*.md",
  callback = function()
    local save_cursor = vim.fn.getpos "."
    local l
    if vim.fn.line "$" > 20 then
      l = 20
    else
      l = vim.fn.line "$"
    end
    vim.fn.execute("1," .. l .. "g/lastmod: /s/lastmod: .*/lastmod: " .. vim.fn.strftime "%Y-%m-%d")
    vim.fn.setpos(".", save_cursor)
  end,
})

-- close some filetypes with <q>
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup "close_with_q",
--   pattern = {
--     "PlenaryTestPopup",
--     "help",
--     "lspinfo",
--     "man",
--     "notify",
--     "qf",
--     "spectre_panel",
--     "startuptime",
--     "tsplayground",
--     "neotest-output",
--     "checkhealth",
--     "neotest-summary",
--     "neotest-output-panel",
--   },
--   callback = function(event)
--     vim.bo[event.buf].buflisted = false
--     vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
--   end,
-- })

-- Autoformatting
--vim.api.nvim_create_autocmd('BufWritePre', {
--callback = function()
--local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
--if client then
--vim.lsp.buf.format()
--end
--end,
--})

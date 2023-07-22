local function augroup(name)
  return vim.api.nvim_create_augroup("pk_" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 150,
      on_visual = false,
    }
    print "Yanked"
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

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
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Autoformatting
--vim.api.nvim_create_autocmd('BufWritePre', {
--callback = function()
--local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
--if client then
--vim.lsp.buf.format()
--end
--end,
--})

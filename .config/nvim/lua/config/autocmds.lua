local function augroup(name)
  return vim.api.nvim_create_augroup("pk" .. name, { clear = true })
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

--vim.api.nvim_create_autocmd("BufEnter", {
--desc = "Remove auto comment for new string",
--callback = function()
--vim.opt.formatoptions:remove { "r", "o" }
--end,
--})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local exclude = { "neo-tree", "toggleterm", "lazy" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, buf, mark)
    end
  end,
})

-- Autoformatting
--if PREF.lsp.format_on_save then
--vim.api.nvim_create_autocmd('BufWritePre', {
--callback = function()
--local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
--if client then
--vim.lsp.buf.format()
--end
--end,
--})
--end

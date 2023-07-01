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
    print("Yanked")
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
--vim.api.nvim_create_autocmd("BufReadPost", {
  --group = augroup("last_loc"),
  --callback = function()
    --local mark = vim.api.nvim_buf_get_mark(0, '"')
    --local lcount = vim.api.nvim_buf_line_count(0)
    --if mark[1] > 0 and mark[1] <= lcount then
      --pcall(vim.api.nvim_win_set_cursor, 0, mark)
    --end
  --end,
--})

local function wp_scratch_buf(start, scratch, lhs)
  for _, buf in ipairs { scratch, start } do
    vim.keymap.set("n", lhs, function()
      vim.api.nvim_buf_delete(scratch, { force = true })
      vim.keymap.del("n", lhs, { buffer = start })
    end, { buffer = buf })
  end
end

-- Diff current buffer " :w !diff %-
vim.api.nvim_create_user_command("DiffOrig", function()
  -- Get start buffer
  local start = vim.api.nvim_get_current_buf()

  -- `vnew` - Create empty vertical split window
  -- `set buftype=nofile` - Buffer is not related to a file, will not be written
  -- `0d_` - Remove an extra empty start row
  -- `diffthis` - Set diff mode to a new vertical split
  vim.cmd "vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis"

  -- Get scratch buffer
  local scratch = vim.api.nvim_get_current_buf()

  -- `wincmd p` - Go to the start window
  -- `diffthis` - Set diff mode to a start window
  vim.cmd "wincmd p | diffthis"

  -- Map `q` for both buffers to exit diff view and delete scratch buffer
  wp_scratch_buf(start, scratch, "q")
end, { desc = "Diff current buffer with the file on disk" })

-- Sort current buffer by second column
vim.api.nvim_create_user_command("MySort", "%!sort -k2nr", { force = true })

-- Sort current buffer by first column
-- vim.api.nvim_create_user_command("AutoFormatToggle", function(args)
--   local __bufnr = vim.api.nvim_get_current_buf()
--   if args.bang then
--     -- AutoFormatToggle! will disable formatting just for this buffer
--     vim.b[__bufnr].disable_autoformat = not vim.b[__bufnr].disable_autoformat
--   else
--     vim.b[__bufnr].disable_autoformat = not vim.b[__bufnr].disable_autoformat
--     vim.g.disable_autoformat = not vim.g.disable_autoformat
--   end
--   print("Setting `autoformatting` to: " .. tostring(not vim.b[__bufnr].disable_autoformat))
-- end, { desc = "Toggle autoformatting", bang = true })

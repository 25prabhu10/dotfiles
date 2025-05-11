local M = {}

M.check_git_workspace = function()
  vim.fn.system "git rev-parse --is-inside-work-tree"

  local is_git_workspace = vim.v.shell_error == 0

  if not is_git_workspace then
    vim.notify "Not a Git repository"
  end
  return is_git_workspace
end

-- Key mapping function
---
---@param mode string|string[] Mode short-name
---@param lhs string Left-hand side
---@param rhs string|function Right-hand side
---@param opts? vim.keymap.set.Opts Additional mapping options
M.map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent or true
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  -- See `:help vim.keymap.set()`
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

local M = {}

M.check_git_workspace = function()
  vim.fn.system "git rev-parse --is-inside-work-tree"

  local is_git_workspace = vim.v.shell_error == 0

  if not is_git_workspace then
    vim.notify "Not a Git repository"
  end
  return is_git_workspace
end

return M

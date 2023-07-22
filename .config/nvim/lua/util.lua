local M = {}

M.check_git_workspace = function()
  local filepath = vim.fn.expand "%:p:h"
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  print(gitdir and #gitdir > 0 and #gitdir < #filepath)
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

return M

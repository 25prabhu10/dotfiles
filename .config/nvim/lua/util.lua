local M = {}

-- Check if the directory is a git repository
M.check_git_workspace = function()
  vim.fn.system "git rev-parse --is-inside-work-tree"

  local is_git_workspace = vim.v.shell_error == 0

  if not is_git_workspace then
    vim.notify "Not a Git repository"
  end
  return is_git_workspace
end

-- Alternative
-- M.check_git_workspace = function ()
--   local filepath = vim.fn.expand "%:p:h"
--   local gitdir = vim.fn.finddir(".git", filepath .. ";")
--   print(gitdir and #gitdir > 0 and #gitdir <#filepath)
--   return gitdir and #gitdir > 0 and #gitdir <#filepath
-- end

-- Autocmds wrapper
M.autocmd = function(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  vim.api.nvim_create_autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
  })
end

-- Go to the next diagnostic, but prefer going to errors first
-- In general, I pretty much never want to go to the next hint
local severity_levels = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.INFO,
  vim.diagnostic.severity.HINT,
}

M.get_highest_error_severity = function()
  for _, level in ipairs(severity_levels) do
    local diags = vim.diagnostic.get(0, { severity = { min = level } })
    if #diags > 0 then
      return level, diags
    end
  end
end

return M

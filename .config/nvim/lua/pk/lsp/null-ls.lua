local M = {}

function M.setup()
  local nls = require "null-ls"

  local sources = {
    -- nls.builtins.formatting.prettierd.with {
    --   filetypes = { "html", "javascript", "json", "typescript", "yaml", "markdown" },
    -- },
    -- nls.builtins.formatting.eslint_d,
    -- nls.builtins.diagnostics.shellcheck,
    nls.builtins.formatting.stylua,
    -- nls.builtins.formatting.black,
    -- nls.builtins.diagnostics.flake8,
    -- nls.builtins.code_actions.gitsigns,
    -- nls.builtins.formatting.prettier,
    -- nls.builtins.diagnostics.markdownlint,
    -- nls.builtins.diagnostics.vale,
  }

  nls.setup {
    debug = false,
    sources = sources,
  }
end

return M

local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "javascript", "typescript", "css", "scss", "html", "lua", "json", "python" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages

    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    ignore_install = {}, -- List of parsers to ignore installing

    highlight = {
      -- use_languagetree = true,
      enable = true, -- false will disable the whole extension
      -- disable = { "css", "html" }, -- list of language that will be disabled
      disable = {}, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return M

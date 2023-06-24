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
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-enter>",
        node_decremental = "<C-backspace>",
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    -- textobjects = {
    --   select = {
    --     enable = true,
    --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    --     keymaps = {
    --       -- You can use the capture groups defined in textobjects.scm
    --       ["aa"] = "@parameter.outer",
    --       ["ia"] = "@parameter.inner",
    --       ["af"] = "@function.outer",
    --       ["if"] = "@function.inner",
    --       ["ac"] = "@class.outer",
    --       ["ic"] = "@class.inner",
    --     },
    --   },
    --   move = {
    --     enable = true,
    --     set_jumps = true, -- whether to set jumps in the jumplist
    --     goto_next_start = {
    --       ["]m"] = "@function.outer",
    --       ["]]"] = "@class.outer",
    --     },
    --     goto_next_end = {
    --       ["]M"] = "@function.outer",
    --       ["]["] = "@class.outer",
    --     },
    --     goto_previous_start = {
    --       ["[m"] = "@function.outer",
    --       ["[["] = "@class.outer",
    --     },
    --     goto_previous_end = {
    --       ["[M"] = "@function.outer",
    --       ["[]"] = "@class.outer",
    --     },
    --   },
    --   swap = {
    --     enable = true,
    --     swap_next = {
    --       ["<leader>a"] = "@parameter.inner",
    --     },
    --     swap_previous = {
    --       ["<leader>A"] = "@parameter.inner",
    --     },
    --   },
    -- },
  }
end

return M

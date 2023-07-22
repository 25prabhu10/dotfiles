return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    },
    cmd = { "TSUpdateSync" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "gnn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["ap"] = { query = "@parameter.outer", desc = "Outer parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "Inner parameter" },

            ["af"] = { query = "@function.outer", desc = "Outer function" },
            ["if"] = { query = "@function.inner", desc = "Inner function" },

            ["ac"] = { query = "@class.outer", desc = "Outer class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },

            ["ab"] = { query = "@block.outer", desc = "Outer block" },
            ["ib"] = { query = "@block.inner", desc = "Inner block" },

            ["av"] = { query = "@variable.outer", desc = "Outer variable" },
            ["iv"] = { query = "@variable.inner", desc = "Inner variable" },

            -- ['ac'] = '@conditional.outer',
            -- ['ic'] = '@conditional.inner',

            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold start" },
          },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Next function end" },
            ["]["] = { query = "@class.outer", desc = "Next class end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Previous function start" },
            ["[["] = { query = "@class.outer", desc = "Previous class start" },
          },
          goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Previous function end" },
            ["[]"] = { query = "@class.outer", desc = "Previous class end" },
          },
          -- goto_next_start = {
          --   ["]f"] = "@function.outer",
          --   ["]m"] = "@class.outer",
          --   ["]p"] = "@parameter.outer",
          --   ["]]"] = "@block.outer",
          --   ["]b"] = "@block.outer",
          --   ["]a"] = "@call.outer",
          --   ["]/"] = "@comment.outer",
          -- },
          -- goto_next_end = {
          --   ["]F"] = "@function.outer",
          --   ["]M"] = "@class.outer",
          --   ["]P"] = "@parameter.outer",
          --   ["]["] = "@block.outer",
          --   ["]B"] = "@block.outer",
          --   ["]A"] = "@call.outer",
          --   ["]\\"] = "@comment.outer",
          -- },
          -- goto_previous_start = {
          --   ["[f"] = "@function.outer",
          --   ["[m"] = "@class.outer",
          --   ["[p"] = "@parameter.outer",
          --   ["[["] = "@block.outer",
          --   ["[b"] = "@block.outer",
          --   ["[a"] = "@call.outer",
          --   ["[/"] = "@comment.outer",
          -- },
          -- goto_previous_end = {
          --   ["[F"] = "@function.outer",
          --   ["[M"] = "@class.outer",
          --   ["[P"] = "@parameter.outer",
          --   ["[]"] = "@block.outer",
          --   ["[B"] = "@block.outer",
          --   ["[A"] = "@call.outer",
          --   ["[\\"] = "@comment.outer",
          -- },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>cn"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
          },
          swap_previous = {
            ["<leader>cp"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
          },
        },
        -- playground = {
        --   enable = true,
        --   disable = {},
        --   updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        --   persist_queries = false, -- Whether the query persists across vim sessions
        --   keybindings = {
        --     toggle_query_editor = "o",
        --     toggle_hl_groups = "i",
        --     toggle_injected_languages = "t",
        --     toggle_anonymous_nodes = "a",
        --     toggle_language_display = "I",
        --     focus_language = "f",
        --     unfocus_language = "F",
        --     update = "R",
        --     goto_node = "<cr>",
        --     show_help = "?",
        --   },
        -- },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

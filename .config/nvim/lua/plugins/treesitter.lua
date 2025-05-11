return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          -- Avoid the sticky context from growing a lot.
          max_lines = 3,
          -- Match the context lines to the source code.
          multiline_threshold = 1,
          -- Disable it when the window is too small.
          min_window_height = 20,
        },
        keys = {
          {
            "[c",
            function()
              -- Jump to previous change when in diffview.
              if vim.wo.diff then
                return "[c"
              else
                vim.schedule(function()
                  require("treesitter-context").go_to_context()
                end)
                return "<Ignore>"
              end
            end,
            desc = "Jump to upper context",
            expr = true,
          },
        },
      },
    },
    config = function()
      -- Use Git instead of curl for downloading the parsers
      require("nvim-treesitter.install").prefer_git = true

      vim.defer_fn(function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup {
          ensure_installed = {
            "bash",
            "c",
            "c_sharp",
            "cpp",
            "css",
            "csv",
            "diff",
            "go",
            "html",
            "http",
            "javascript",
            "jsdoc",
            "json",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "nginx",
            "proto",
            "python",
            "query",
            "regex",
            "rust",
            "scss",
            "sql",
            "templ",
            "toml",
            "tsx",
            "typescript",
            "vue",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
          },

          -- Auto-install languages that are not installed (default: false)
          auto_install = false,
          indent = { enable = true, disable = { "ruby", "yaml" } },
          highlight = {
            enable = true,
            -- disable slow treesitter highlight for large files
            disable = function(_, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
            additional_vim_regex_highlighting = false, --{ "ruby" },
          },
          incremental_selection = {
            enable = true,
            disable = { "ruby" },
            keymaps = {
              init_selection = "<Enter>", -- maps in normal mode to init the node/scope selection
              node_incremental = "<Enter>", -- increment to the upper name parent
              scope_incremental = false, -- increment to the upper scope (as defined in `locals.scm`)
              node_decremental = "<Backspace>", -- decrement to the previous node
            },
            -- keymaps = {
            --   init_selection = "gnn", -- maps in normal mode to init the node/scope selection
            --   node_incremental = "grn", -- increment to the upper name parent
            --   node_decremental = "grm", -- decrement to the previous node
            --   scope_incremental = "grc", -- increment to the upper scope (as defined in `locals.scm`)
            -- },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
                ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },

                ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },

                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },

                ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
                ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },

                ["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
                ["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },

                -- ["a/"] = { query = "@call.outer", desc = "Select outer part of a call" },
                -- ["i/"] = { query = "@call.inner", desc = "Select inner part of a call" },

                ["a?"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                ["i?"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
              },
              include_surrounding_whitespace = true,
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
                ["<Leader>cn"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
              },
              swap_previous = {
                ["<Leader>cp"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
              },
            },
          },
        }

        vim.opt.foldmethod = "expr" -- Tree-sitter based folding
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      end, 0)
    end,
  },
}

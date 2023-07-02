return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    cmd = { "TSUpdateSync" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
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
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = "<C-CR>",
          node_decremental = "<C-BS>",
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
            ["aa"] = { query = "@parameter.outer", desc = "" },
            ["ia"] = { query = "@parameter.inner", desc = "" },
            ["af"] = { query = "@function.outer", desc = "" },
            ["if"] = { query = "@function.inner", desc = "" },
            ["ac"] = { query = "@class.outer", desc = "" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "" },
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "" },
            ["]["] = { query = "@class.outer", desc = "Next class end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "" },
            ["[["] = { query = "@class.outer", desc = "" },
          },
          {
            ["[M"] = { query = "@function.outer", desc = "" },
            ["[]"] = { query = "@class.outer", desc = "" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = { query = "@parameter.inner", desc = "" },
          },
          swap_previous = {
            ["<leader>A"] = { query = "@parameter.inner", desc = "" },
          },
        },
      },
    },
    config = function(_, opts)
      --if type(opts.ensure_installed) == "table" then
      --local added = {}
      --opts.ensure_installed = vim.tbl_filter(function(lang)
      --if added[lang] then
      --return false
      --end
      --added[lang] = true
      --return true
      --end, opts.ensure_installed)
      --end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

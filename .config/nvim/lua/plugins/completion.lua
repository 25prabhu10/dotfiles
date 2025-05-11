return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- Provides snippets for the snippet source
    dependencies = {
      -- {
      --   "L3MON4D3/LuaSnip",
      --   -- follow latest release.
      --   version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      --   -- install jsregexp (optional!).
      --   build = "make install_jsregexp",
      --   dependencies = {
      --     -- `friendly-snippets` contains a variety of premade snippets.
      --     --    See the README about individual language/framework/plugin snippets:
      --     --    https://github.com/rafamadriz/friendly-snippets
      {
        "rafamadriz/friendly-snippets",
        -- config = function()
        --   require("luasnip.loaders.from_vscode").lazy_load()
        -- end,
      },
      -- },
      -- opts = {},
      -- },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "default" },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your configuration, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "lazydev", "buffer" },
        per_filetype = { sql = { "dadbod" } },
        providers = {
          dadbod = { module = "vim_dadbod_completion.blink" },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      -- snippets = { preset = "luasnip" },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true, window = { border = "rounded" } },
      completion = {
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}

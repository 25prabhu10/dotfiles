return {
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          "L3MON4D3/LuaSnip",
          dependencies = {
            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
          opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        },
      },

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      --Plug 'hrsh7th/cmp-cmdline'
    },
    event = "InsertEnter",
    config = function()
      -- Autocompletion setup
      local kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      local luasnip = require "luasnip"

      -- This will expand the current item or jump to the next item within the
      -- snippet.
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true, desc = "Expand or Jump in snippet" })

      -- This always moves to the previous item within the snippet
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true, desc = "Jump back in snippet" })

      local cmp = require "cmp"
      ---@diagnostic disable-next-line missing-fields
      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer", max_item_count = 3, keywod_length = 3 },
          { name = "path" },
          --{ name = "nvim_lua" },
        },
        mapping = {
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { "i", "c" }
          ),
          ["<C-Space>"] = cmp.mapping {
            i = cmp.mapping.complete(),
            c = function(
              _ --[[fallback]]
            )
              if cmp.visible() then
                if not cmp.confirm { select = true } then
                  return
                end
              else
                cmp.complete()
              end
            end,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        ---@diagnostic disable-next-line missing-fields
        formatting = {
          fields = { "abbr", "menu", "kind" },
          format = function(entry, item)
            local short_name = {
              buffer = "Buffer",
              nvim_lsp = "LSP",
              luasnip = "LuaSnip",
              nvim_lua = "Lua",
              latex_symbols = "Latex",
            }
            local menu_name = short_name[entry.source.name] or entry.source.name
            item.menu = string.format("[%s]", menu_name)

            item.kind = string.format("%s %s", kind_icons[item.kind] or "", item.kind)
            return item
          end,
        },
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
        -- experimental = {
        --   ghost_text = true,
        -- },
      }
    end,
  },
}

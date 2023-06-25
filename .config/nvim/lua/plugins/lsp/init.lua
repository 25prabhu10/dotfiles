return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      --{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",

      -- Autocompletion
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          -- Snippet Engine & its associated nvim-cmp source
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",

          -- Adds LSP completion capabilities
          "hrsh7th/cmp-nvim-lsp",
          --Plug 'hrsh7th/cmp-buffer'
          --Plug 'hrsh7th/cmp-path'
          --Plug 'hrsh7th/cmp-cmdline'

          -- Adds a number of user-friendly snippets
          --'rafamadriz/friendly-snippets',
        },
      },
    },
    event = { "BufReadPre", "bufNewFile" },
    config = function()
      local servers = {
        bashls = {},
        clangd = {},
        -- gopls = {},
        -- jsonls = {},
        lua_ls = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        -- pyright = {},
        -- rust_analyzer = {},
        tsserver = {
          enable_import_on_completion = true,

          -- import all
          import_all_timeout = 5000, -- ms
          import_all_priorities = {
            buffers = 4, -- loaded buffer names
            buffer_content = 3, -- loaded buffer content
            local_files = 2, -- git files or files with relative path markers
            same_file = 1, -- add to existing import statement
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,
        },
      }

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        if client.name == "lua_ls" or client.name == "tsserver" then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- Key bindings
        local map = function(mode, keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Format document
        map("n", "<leader>fd", vim.lsp.buf.format, "Format current buffer with LSP")
        --if client.supports_method('textDocument/formatting') == false then
        --local msg = '%s does not support textDocument/formatting method'
        --vim.notify(msg:format(client.name), vim.log.levels.WARN)
        --else
        --end

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions

        -- See `:help K` for why this keymap
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

        map("n", "<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("n", "gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("n", "gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")

        --map("n", '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        --map("n", '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        map("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        -- Diagnostics
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        map("n", "[d", vim.diagnostic.goto_prev, "goto prev [d]iagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "goto next [d]iagnostic")
        map("n", "<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
        --map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')
      end

      -- Setup neovim lua configuration
      require("neodev").setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require "mason-lspconfig"

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }

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
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup {}

      local cmp = require "cmp"
      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          --{ name = "buffer", max_item_count = 5, keywod_length = 5 },
          --{ name = "path" },
          --{ name = "nvim_lua" },
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-y>"] = cmp.mapping.confirm { select = true },
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete {},
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
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
        --window = {
        --completion = cmp.config.window.bordered(),
        --documentation = cmp.config.window.bordered(),
        --},
        experimental = {
          native_menu = false,
          --ghost_text = true,
        },
      }
    end,
  },
  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local null_ls = require "null-ls"
      return {
        debug = false,
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
          --null_ls.builtins.formatting.fish_indent,
          --null_ls.builtins.diagnostics.fish,
          --null_ls.builtins.formatting.shfmt,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}

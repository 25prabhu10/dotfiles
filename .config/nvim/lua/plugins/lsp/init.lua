return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      --"williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      --{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    event = { "BufReadPre", "bufNewFile" },
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        if client.name == "tsserver" then
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
        map("n", "<Leader>fd", function()
          vim.lsp.buf.format { async = true }
        end, "Format current buffer with LSP")

        --if client.supports_method('textDocument/formatting') == false then
        --local msg = '%s does not support textDocument/formatting method'
        --vim.notify(msg:format(client.name), vim.log.levels.WARN)
        --else
        --end

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions

        -- See `:help K` for why this keymap
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

        map("n", "<F2>", vim.lsp.buf.rename, "Rename")
        map("n", "<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("n", "gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("n", "gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")

        map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("n", "<Leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        -- Diagnostics
        -- See `:help vim.diagnostic.*` for documentation on any of the below
        -- functions
        map("n", "[d", vim.diagnostic.goto_prev, "Goto prev [D]iagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Goto next [D]iagnostic")
        map("n", "<Leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
        --map('n', '<Leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')
      end

      -- Setup neovim lua configuration
      require("neodev").setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast
      -- that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- capabilities.textDocument.completion.completionItem = {
      --   documentationFormat = { "markdown", "plaintext" },
      --   snippetSupport = true,
      --   preselectSupport = true,
      --   insertReplaceSupport = true,
      --   labelDetailsSupport = true,
      --   deprecatedSupport = true,
      --   commitCharactersSupport = true,
      --   tagSupport = { valueSet = { 1 } },
      --   resolveSupport = {
      --     properties = {
      --       "documentation",
      --       "detail",
      --       "additionalTextEdits",
      --     },
      --   },
      -- }

      -- Configure LSP servers
      local lspconfig = require "lspconfig"

      lspconfig["bashls"].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {},
      }

      lspconfig["clangd"].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
        },
        init_options = {
          clangdFileStatus = true,
        },
        settings = {},
      }

      lspconfig["lua_ls"].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            format = {
              enable = false,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                continuation_indent_size = "2",
              },
            },
          },
        },
      }

      lspconfig["tsserver"].setup {
        capabilities = capabilities,
        cmd = { "typescript-language-server", "--stdio" },
        on_attach = on_attach,
        keys = {
          { "<Leader>co", "<Cmd>TypescriptOrganizeImports<CR>", desc = "Typescript Organize Imports" },
          { "<Leader>cr", "<Cmd>TypescriptRenameFile<CR>", desc = "Typescript Rename File" },
        },
        settings = {
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
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "literal",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
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
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.markdownlint,
          --null_ls.builtins.completion.spell,
          --null_ls.builtins.diagnostics.fish,
          --null_ls.builtins.formatting.isort,
          --null_ls.builtins.formatting.black,
          --nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}

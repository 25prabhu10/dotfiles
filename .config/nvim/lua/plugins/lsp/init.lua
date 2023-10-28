return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      --"williamboman/mason-lspconfig.nvim",

      -- Additional lua configuration, makes nvim stuff amazing!
      { "folke/neodev.nvim", lazy = true },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      inlay_hints = { enabled = true },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          severity = nil,
          source = "if_many",
          format = nil,
        },
        signs = true,
        -- options for floating windows:
        float = {
          show_header = true,
          -- border = "rounded",
          -- source = "always",
          format = function(d)
            if not d.code and not d.user_data then
              return d.message
            end

            local t = vim.deepcopy(d)
            local code = d.code
            if not code then
              if not d.user_data.lsp then
                return d.message
              end

              code = d.user_data.lsp.code
            end
            if code then
              t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
            end
            return t.message
          end,
        },
      },
    },
    config = function()
      -- Go to the next diagnostic, but prefer going to errors first
      -- In general, I pretty much never want to go to the next hint
      local severity_levels = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT,
      }

      local get_highest_error_severity = function()
        for _, level in ipairs(severity_levels) do
          local diags = vim.diagnostic.get(0, { severity = { min = level } })
          if #diags > 0 then
            return level, diags
          end
        end
      end

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
        map("n", "<Leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

        map("n", "gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
        map("n", "gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
        map("n", "gI", vim.lsp.buf.implementation, "[g]oto [I]mplementation")
        map("n", "gt", vim.lsp.buf.type_definition, "[g]oto [t]ype Definition")

        map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd Folder")
        map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove Folder")
        map("n", "<Leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[w]orkspace [l]ist Folders")

        -- Diagnostics
        -- See `:help vim.diagnostic.*` for documentation on any of the below
        -- functions
        map("n", "[d", function()
          vim.diagnostic.goto_prev {
            severity = get_highest_error_severity(),
            wrap = true,
            float = true,
          }
        end, "Goto prev [d]iagnostic")
        map("n", "]d", function()
          vim.diagnostic.goto_next {
            severity = get_highest_error_severity(),
            wrap = true,
            float = true,
          }
        end, "Goto next [d]iagnostic")
        map("n", "<Leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
        map("n", "<Leader>q", vim.diagnostic.setloclist, "Open diagnostics list")
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

      lspconfig["pyright"].setup {
        capabilities = capabilities,
        on_attach = on_attach,
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
  -- Formatters and diagnostics
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local null_ls = require "null-ls"
      return {
        debug = false,
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier.with {
            prefer_local = "node_modules/prettier",
            extra_args = { "--no-semi", "--single-quote" },
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "jsonc",
              "yaml",
              "markdown",
              "markdown.mdx",
              "graphql",
              "handlebars",
            },
          },
          -- null_ls.builtins.formatting.jq,
          -- null_ls.builtins.formatting.autopep,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.black,
          -- null_ls.builtins.formatting.clang_format,

          -- null_ls.builtins.diagnostics.markdownlint_cli2.with {
          --   prefer_local = "node_modules/.bin",
          --   extra_args = { "--config " .. require("null-ls.utils").get_root() .. "/.markdownlint.yaml" },
          --   condition = function(utils)
          --     return utils.root_has_file { ".markdownlint.yaml" }
          --   end,
          -- },

          null_ls.builtins.diagnostics.eslint.with {
            prefer_local = "node_modules/.bin",
            condition = function(utils)
              return utils.root_has_file {
                "eslint.config.js",
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
              }
            end,
          },

          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff,

          -- null_ls.builtins.diagnostics.fish,
          -- null_ls.builtins.diagnostics.pylint
          -- null_ls.builtins.diagnostics.flake8,
          -- null_ls.builtins.diagnostics.cppcheck,

          -- null_ls.builtins.code_actions.gitsigns,

          -- null_ls.builtins.completion.spell,
        },
      }
    end,
  },
}

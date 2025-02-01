return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Additional lua configuration, makes nvim stuff amazing!
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- config.capabilities = require('blink.cmp').get_lsp_capabilities()
      --
      -- local lsp_config = require('lspconfig')
      --
      -- lsp_config.lua_ls.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("pk-lsp-attach", { clear = true }),
        callback = function(args)
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if not client then
            return
          end

          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("pk-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = args.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = args.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("pk-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "pk-lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          -- Enable completion triggered by <c-x><c-o>
          if client.server_capabilities.completionProvider then
            vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = args.buf })
          end

          if client.server_capabilities.definitionProvider then
            vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = args.buf })
          end

          if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf })
          end

          -- Global Handlers for LSP
          ---@param methodName string: The method name
          ---@param fn function: The function to call
          ---@param ... any: The arguments to pass to the function
          local globalHandlers = function(methodName, fn, ...)
            -- if assign function if ... is empty
            if client.supports_method(methodName) then
              client.handlers[methodName] = ... and fn(...) or fn
            end
          end

          globalHandlers("textDocument/signatureHelp", vim.lsp.with, vim.lsp.handlers.signature_help, { border = "rounded" })
          globalHandlers("textDocument/hover", vim.lsp.with, vim.lsp.handlers.hover, { border = "rounded" })
          globalHandlers("textDocument/defintion", function(_, result)
            if not result or vim.tbl_isempty(result) then
              print "[LSP] Could not find defintion!!"
              return
            end

            if vim.islist(result) then
              vim.lsp.util.jump_to_location(result[1], "utf-8")
            else
              vim.lsp.util.jump_to_location(result, "utf-8")
            end
          end)

          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<F2>", vim.lsp.buf.rename, "Rename")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<Leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        end,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              completion = {
                callSnippet = "Replace",
              },
              format = {
                enable = false,
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })

      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      ---@diagnostic disable-next-line: missing-fields
      require("mason-lspconfig").setup {
        -- See `:h mason-lspconfig.setup_handlers()`
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, require("blink.cmp").get_lsp_capabilities(server.capabilities), server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }

        local lsp_format_opt

        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end

        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,

      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}

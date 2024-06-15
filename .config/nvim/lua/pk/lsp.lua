local mason_lspconfig = require "mason-lspconfig"

local M = {}

function M.setup()
  -- vim.lsp.set_log_level "trace"
  local servers = {
    bashls = {},
    clangd = {
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
    },
    -- html = {},
    jsonls = {
      settings = {
        json = {
          format = {
            enable = true,
          },
          -- schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    lua_ls = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          -- Tells lua_ls where to find all the Lua files that you have loaded
          -- for your neovim configuration.
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
          -- If lua_ls is really slow on your computer, you can try this instead:
          -- library = { vim.env.VIMRUNTIME },
        },
        telemetry = { enable = false },
        completion = {
          callSnippet = "Replace",
        },
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

    pyright = {},
  }

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- Enable completion triggered by <c-x><c-o>
      if client and client.server_capabilities.completionProvider then
        vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = event.buf })
      end
      if client and client.server_capabilities.definitionProvider then
        vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = event.buf })
      end

      -- Set autocommands conditionally on server_capabilities
      if client and client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end

      -- Global Handlers
      local globalHandlers = function(methodName, fn, ...)
        -- if client.supports_method(methodName) == false then
        -- local msg = "%s dose not support %s method"
        -- msg = string.format(msg, client.name, methodName)
        -- vim.notify_once(msg, vim.log.levels.TRACE)
        -- else
        -- if assign function if ... is empty
        if client then
          client.handlers[methodName] = ... and fn(...) or fn
        end
        -- end
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

      --if client.supports_method('textDocument/formatting') == false then
      --local msg = '%s does not support textDocument/formatting method'
      --vim.notify(msg:format(client.name), vim.log.levels.WARN)
      --else
      --end

      -- Key bindings
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions

      -- See `:help K` for why this keymap
      -- map("K", vim.lsp.buf.hover, "Hover documentation")
      map("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

      map("<F2>", vim.lsp.buf.rename, "Rename")
      map("<Leader>ca", function()
        vim.lsp.buf.code_action {
          context = {
            only = {
              "source",
            },
            diagnostics = {},
          },
        }
      end, "Code Action")

      map("gd", vim.lsp.buf.definition, "Goto Definition")
      map("gD", vim.lsp.buf.declaration, "Goto Declaration")
      map("gI", vim.lsp.buf.implementation, "Goto Implementation")
      map("gt", vim.lsp.buf.type_definition, "Goto Type Definition")

      map("<Leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
      map("<Leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
      map("<Leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "Workspace List Folders")

      -- Format document using LSP
      -- map("n", "<Leader>fd", function()
      --   vim.lsp.buf.format { async = false }
      -- end, "Format current buffer with LSP")
    end,
  })

  -- Setup neovim lua configuration
  require("neodev").setup()

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP Specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  -- nvim-cmp supports additional completion capabilities, so broadcast
  --  that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      require("lspconfig")[server_name].setup(server)
    end,
  }
end

return M

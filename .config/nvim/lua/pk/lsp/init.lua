local M = {}

local function setup_servers()
  -- setup mason so it can manage external tooling
  require("mason").setup()
  local mason_lspconfig = require "mason-lspconfig"

  local servers = { "bashls", "clangd", "lua_ls", "tsserver" }

  mason_lspconfig.setup {
    ensure_installed = servers,
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local opts = {
        on_attach = require("pk.lsp.handlers").on_attach,
        capabilities = require("pk.lsp.handlers").capabilities,
      }
      local has_custom_opts, server_custom_opts = pcall(require, "pk.lsp." .. server_name)

      if has_custom_opts then
        opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
      end

      require("lspconfig")[server_name].setup(opts)
    end,
  }
end

function M.setup()
  require("pk.lsp.null-ls").setup()

  -- Setup neovim lua configuration
  -- require("neodev").setup()

  setup_servers()

  -- Turn on lsp status information
  require("fidget").setup()
end

return M

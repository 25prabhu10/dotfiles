local M = {}

local function setup_servers()
  local lspconfig = require "lspconfig"
  local lsp_installer = require "nvim-lsp-installer"

  require("pk.lsp.null-ls").setup()

  local servers = { "sumneko_lua", "tsserver" }

  lsp_installer.setup {
    ensure_installed = servers,
  }

  for _, server in pairs(servers) do
    local opts = {
      on_attach = require("pk.lsp.handlers").on_attach,
      capabilities = require("pk.lsp.handlers").capabilities,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "pk.lsp." .. server)

    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end

function M.setup()
  setup_servers()
end

return M

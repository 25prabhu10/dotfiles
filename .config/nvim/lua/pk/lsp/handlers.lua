local M = {}

-- function M.setup()
-- end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = 0 }
  local opts_global = { noremap = true, silent = true }

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help<CR>", opts)
  --vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  --vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  --vim.keymap.set("n", "<Leader>wl", vim.inspect(vim.lsp.buf.list_workspace_folders), opts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  --vim.keymap.set("n", "<Leader>f", vim.lsp.buf.formatting, opts)

  -- Diagnostics
  vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts_global)
  vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_prev, opts_global)
  vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_next, opts_global)
  vim.keymap.set("n", "<Leader>dl", "<cmd>Telescope diagnostics<CR>", opts_global)
  --vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts_global)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
end

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

M.on_attach = function(client, bufnr)
  -- disable autoformatting for JavaScript, HTML
  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  lsp_keymaps(bufnr)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return M

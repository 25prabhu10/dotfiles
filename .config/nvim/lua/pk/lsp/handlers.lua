local M = {}

local function lsp_keymaps(bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap("<Leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
  nmap("<Leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

  nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
  nmap("gI", vim.lsp.buf.implementation, "[g]oto [I]mplementation")
  nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
  nmap("gt", vim.lsp.buf.type_definition, "[g]oto [t]ype definition")
  nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation" })
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help<CR>", opts)

  -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  -- nmap("<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, "[W]orkspace [L]ist Folders")

  -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- Diagnostics
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  nmap("<Leader>e", vim.diagnostic.open_float, "Open diagnostics")
  nmap("[d", vim.diagnostic.goto_prev, "goto prev [d]iagnostic")
  nmap("]d", vim.diagnostic.goto_next, "goto next [d]iagnostic")
  --nmap("<Leader>q", vim.diagnostic.setloclist, "")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format { async = true }
  end, { desc = "Format current buffer with LSP" })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  lsp_keymaps(bufnr)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return M

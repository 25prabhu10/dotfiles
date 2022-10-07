local M = {}

function M.setup()
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  -- Don"t show the dumb matching stuff.
  --vim.opt.shortmess:remove "c"

  local luasnip = require "luasnip"
  local cmp = require "cmp"

  local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
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
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-y>"] = cmp.mapping.confirm { select = true },
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.config.disable,
      --["<C-y"] = cmp.mapping(
      --cmp.mapping.confirm {
      --behavior = cmp.ConfirmBehavior.Insert,
      --select = true
      --},
      --{ "i", "c" }
      --),
      --["<Leader><CR>"] = cmp.mapping {
      --i = cmp.mapping.complete(),
      --c = function(
      --_ --[[fallback]]
      --)
      --if cmp.visible() then
      --cmp.select_next_item()
      --if not cmp.confirm { select = true } then
      --return
      --end
      --else
      --cmp.complete()
      --end
      --end,
      --},
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer", max_item_count = 5, keywod_length = 5 },
      { name = "path" },
      { name = "nvim_lua" },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(_, vim_item)
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
        return vim_item
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
  }
end

return M

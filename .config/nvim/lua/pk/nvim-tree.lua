local M = {}

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

function M.setup()
  -- Nvim-Tree Mappings
  vim.keymap.set("n", "<Leader>n", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })

  require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      side = "right",
      preserve_window_proportions = true,
    },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "✗",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      custom = { "node_modules" },
    },
  }

  open_nvim_tree()
end

return M

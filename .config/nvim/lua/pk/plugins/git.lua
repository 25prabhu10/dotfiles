return {
  -- {
  --   "tpope/vim-fugitive",
  --   cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
  --   event = "BufRead",
  --   config = function()
  --     vim.keymap.set("n", "<Leader>ggl", "<Cmd>Git log %<CR>", { desc = "Git log of current buffer" })
  --     vim.keymap.set("n", "<Leader>ggL", "<Cmd>Git l<CR>", { desc = "Git log" })
  --     -- vim.keymap.set("n", "<Leader>ggS", "<Cmd>Git show<CR>", { desc = "Git show" })
  --     vim.keymap.set("n", "<Leader>ggB", "<Cmd>Git blame<CR>", { desc = "Git blame" })
  --     vim.keymap.set("n", "<Leader>ggC", ":Git checkout<Space>", { desc = "Git checkout <branch>" })
  --     vim.keymap.set("n", "<Leader>ggS", "<Cmd>Gvdiffsplit<CR>", { desc = "Git diff vsplit" })
  --
  --     -- vim.keymap.set("n", "<Leader>ght", "<Cmd>G difftool<CR>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ght", "<Cmd>G mergetool<CR>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ggw", "<Cmd>Gwrite<CR>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ggr", ":G rebase -i<Space>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ggR", "<Cmd>Gread<CR>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ggM", ":GMove<CR>=expand('%:p')<CR>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ggc", "<Cmd>Git commit<CR>", { desc = "" })
  --     -- vim.keymap.set("n", "<Leader>ggC", "<Cmd>Git commit --amend<CR>", { desc = "" })
  --   end,
  -- },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "]h", gs.next_hunk, { desc = "Next git Hunk" })
          map("n", "[h", gs.prev_hunk, { desc = "Next git Hunk" })
          map("n", "<Leader>ghS", gs.stage_buffer, { desc = "Stage git Buffer" })
          map("n", "<Leader>ghR", gs.reset_buffer, { desc = "Reset git buffer" })
          map("v", "<Leader>ghs", function()
            gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, { desc = "Stage Hunk in selected lines" })
          map("v", "<Leader>ghr", function()
            gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, { desc = "Rest Hunk in selected lines" })
          map("n", "<Leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage git Hunk" })
          map("n", "<Leader>ghp", gs.preview_hunk_inline, { desc = "Preview git hunk inline" })
          map("n", "<Leader>ghP", gs.preview_hunk, { desc = "Preview git hunk" })
          map("n", "<Leader>ghb", function()
            gs.blame_line { full = true }
          end, { desc = "Git Blame Line" })
          map("n", "<Leader>ghd", gs.diffthis, { desc = "Git diff last commit" })
          map("n", "<Leader>ghD", function()
            gs.diffthis "~2"
          end, { desc = "Git diff second last commit" })
          map("n", "<Leader>ght", gs.toggle_current_line_blame, { desc = "Toggle Git Blame Line" })
          map("n", "<Leader>ghT", gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
        end,
      }
    end,
  },
}

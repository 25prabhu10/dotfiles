return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
      vim.keymap.set("n", "<Leader>ggl", "<Cmd>Git log %<CR>", { desc = "Git log of current buffer" })
      vim.keymap.set("n", "<Leader>ggL", "<Cmd>Git l<CR>", { desc = "Git log" })
      -- vim.keymap.set("n", "<Leader>ggS", "<Cmd>Git show<CR>", { desc = "Git show" })
      vim.keymap.set("n", "<Leader>ggB", "<Cmd>Git blame<CR>", { desc = "Git blame" })
      vim.keymap.set("n", "<Leader>ggC", ":Git checkout<Space>", { desc = "Git checkout <branch>" })
      vim.keymap.set("n", "<Leader>ggS", "<Cmd>Gvdiffsplit<CR>", { desc = "Git diff vsplit" })

      -- vim.keymap.set("n", "<Leader>ght", "<Cmd>G difftool<CR>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ght", "<Cmd>G mergetool<CR>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ggw", "<Cmd>Gwrite<CR>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ggr", ":G rebase -i<Space>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ggR", "<Cmd>Gread<CR>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ggM", ":GMove<CR>=expand('%:p')<CR>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ggc", "<Cmd>Git commit<CR>", { desc = "" })
      -- vim.keymap.set("n", "<Leader>ggC", "<Cmd>Git commit --amend<CR>", { desc = "" })
    end,
  },
}

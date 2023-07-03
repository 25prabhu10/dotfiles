-- UndoTree Plugin Settings

vim.opt.undofile = true
vim.opt.history = 500
vim.opt.undolevels = 700
vim.opt.undoreload = 700

vim.keymap.set("n", "<Leader><F5>", vim.cmd.UndotreeToggle, { silent = true, desc = "Toggle UndoTree" })

vim.g.undotree_SetFocusWhenToggle = 1

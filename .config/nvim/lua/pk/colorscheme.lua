-- attempt to determine the type of a file based on its name and possibly its
-- contents. use this to allow intelligent auto-indenting for each filetype,
-- and for plugins that are file type specific.

--filetype plugin indent on

vim.opt.termguicolors = true -- Enable 24bit colors
vim.opt.background = "dark"

-- require("tokyonight").setup {
--   style = "night", -- Possible values: storm, night and day
-- }

-- Enable syntax highlighting
vim.cmd [[colorscheme kanagawa]]

-- Catch colorscheme error not found errors
--local colorscheme = "tokyonight"
--
--local statis_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
--if not statis_ok then
--  vim.notify("colorscheme " .. colorscheme .. " not found!")
--  return
--end

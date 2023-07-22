-- Install plugin manager and load configs
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = { import = "plugins" },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        -- "bugreport",
        -- "editorconfig",
        -- "ftplugin",
        -- "compiler",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        -- "netrw",
        -- "netrwPlugin",
        -- "netrwSettings",
        -- "netrwFileHandlers",
        "matchit",
        "matchparen",
        "rplugin",
        "rrhelper",
        -- "spellfile_plugin",
        -- "synmenu",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
}

-- Disable builtin vim
--vim.g.loaded_gzip = 1
--vim.g.loaded_zip = 1
--vim.g.loaded_zipPlugin = 1
--vim.g.loaded_tar = 1
--vim.g.loaded_tarPlugin = 1

--vim.g.loaded_getscript = 1
--vim.g.loaded_getscriptPlugin = 1
--vim.g.loaded_vimball = 1
--vim.g.loaded_vimballPlugin = 1
--vim.g.loaded_2html_plugin = 1

--vim.g.loaded_matchit = 1
--vim.g.loaded_matchparen = 1
--vim.g.loaded_logiPat = 1
--vim.g.loaded_rrhelper = 1

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
--vim.g.loaded_netrwSettings = 1

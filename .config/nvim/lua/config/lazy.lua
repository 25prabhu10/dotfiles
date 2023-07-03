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
        -- "2html_plugin",
        -- "bugreport",
        -- "editorconfig",
        -- "ftplugin",
        -- "compiler",
        -- "getscript",
        -- "getscriptPlugin",
        "gzip",
        -- "logipat",
        -- "netrw",
        -- "netrwPlugin",
        -- "netrwSettings",
        -- "netrwFileHandlers",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "rplugin",
        -- "rrhelper",
        -- "spellfile_plugin",
        -- "synmenu",
        -- "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        -- "vimball",
        -- "vimballPlugin",
        -- "zip",
        "zipPlugin",
      },
    },
  },
}

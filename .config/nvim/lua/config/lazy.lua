-- Install plugin manager and load configs
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/pk/plugins/` folder
require("lazy").setup {
  spec = {
    { import = "plugins" }, -- import your plugins
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = false,
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
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
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

-- Disable built-in vim
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

-- :help options

-- This adds the current directory to the :Find files feature (in-built)
-- Provides tab-completion for all file-related tasks
vim.opt.path:append "**"
--"set dictionary+=/usr/share/dict/words

-- This stops Vim from redrawing the screen during complex operations and results
-- in much smoother looking plugins.
vim.opt.lazyredraw = true

-- No swap and No backup files
vim.opt.swapfile = false --don't create swapfiles for new buffers
vim.opt.backup = false --don't use backup files
vim.opt.writebackup = false --don't backup the file while editing
vim.opt.updatecount = 0 --don't try to write swap files after some number of updates

-- The same indent as the line you're currently on. Useful for READMEs, etc.
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4 --insert mode tab and backspace use 4 spaces
vim.opt.shiftwidth = 4 --normal mode indentation commands use 4 spaces
vim.opt.shiftround = true --round indent to a multiple of 'shiftwidth'

vim.opt.foldenable = false --do not fold on file opening
vim.opt.foldmethod = "expr" --Tree-sitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.mouse = "a" --mouse support

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

vim.opt.wrap = false --disable soft wrapping

-- File split will follow the bellow convention.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show “invisible” characters
vim.opt.list = true
vim.opt.listchars = { tab = "»·", trail = "·", nbsp = "·", extends = "❯", precedes = "❮" }
vim.opt.showbreak = "↪"

vim.opt.hlsearch = true --highlight searches

-- Case-sensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.title = true

-- Line numbering
vim.opt.relativenumber = true
vim.opt.number = true

-- Don't show mode
vim.opt.showmode = false

-- Auto Read if file updated externally
vim.opt.autoread = true

-- Vertical line on column 80
vim.opt.colorcolumn = { 80 }

-- Enable highlighting of the current line
vim.opt.cursorline = true

-- Only have it on in the active buffer
--local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
--local set_cursorline = function(event, value, pattern)
--vim.api.nvim_create_autocmd(event, {
--group = group,
--pattern = pattern,
--callback = function()
--vim.opt_local.cursorline = value
--end,
--})
--end
--set_cursorline("WinLeave", false)
--set_cursorline("WinEnter", true)
--set_cursorline("FileType", false, "TelescopePrompt")

-- vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.clipboard = ""

-- Autocomplete with dictionary words when spell check is on
--set complete+=kspell
--" set dictionary+=/usr/share/dict/words
--" set thesaurus+=/home/prabhu/Thesaurus/words

-- Wildmode Options
vim.opt.wildmenu = true
-- Command <Tab> completion, list matches, then longest common part, then all
vim.opt.wildmode = "longest:full,full"
-- Version control
vim.opt.wildignore:append { ".hg", ".git", ".svn" }
vim.opt.wildignore:append { "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg" }
-- compiled object files
vim.opt.wildignore:append { "*.o", "*.obj", "*.exe", "*.dll", "*.manifest" }
-- Vim swap files
vim.opt.wildignore:append { "*.sw?" }
-- OSX bullshit
vim.opt.wildignore:append { "*.DS_Store" }
-- Django migrations
vim.opt.wildignore:append { "migrations" }
-- Python byte code
vim.opt.wildignore:append { "__pycache__", "*.pyc" }
-- Node modules
vim.opt.wildignore:append { "node_modules" }

-- Always show tabs
--"set showtabline=2

-- Source .vimrc present in the project directory
--"set exrc

vim.opt.inccommand = "split" --show live replace

vim.opt.matchpairs:append { "<:>" }

vim.opt.updatetime = 500 --faster completion
vim.wo.signcolumn = "yes"

--vim.opt.iskeywork:append { "-" }  --conside words split by '-' as one

--vim.g.python3_host_prog = '/usr/bin/python3'    --Python 3 provider (optional)
-- Disable providers we do not care a about
--vim.g.loaded_python_provider  = 0
--vim.g.loaded_ruby_provider    = 0
--vim.g.loaded_perl_provider    = 0
--vim.g.loaded_node_provider    = 0

vim.opt.formatoptions = vim.opt.formatoptions
  + "c" -- Comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  - "r" -- Don't insert comment after <Enter>
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- Not in gradeschool anymore
  + "l" -- Long lines are not broken in insert mode
-- - "a" -- Auto formatting is BAD.
-- - "t" -- Don't auto format my code. Linters can do that.

-- Highlight yanked text
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", { clear = true })

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 150,
      on_visual = false,
    }
  end,
})

vim.cmd [[
  augroup configgroup
      autocmd!
      " When editing a file, always jump to the last known cursor position.
      " Don't do it for commit messages, when the position is invalid, or when
      " inside an event handler (happens when dropping a file on gvim).
      autocmd BufReadPost *
                  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal g`\"" |
                  \ endif
  augroup END
]]

-- File templates
vim.cmd [[
  autocmd BufNewFile *.sh 0r ~/.config/nvim/skeletons/bash.sh
  autocmd BufNewFile *.md 0r ~/.config/nvim/skeletons/markdown.md
]]

vim.cmd [[
  autocmd BufNewFile *.md |call PageCreated()|
  fun PageCreated()
    if line("$") > 20
      let l = 20
    else
      let l = line("$")
    endif
    exe "1," .. l .. "g/date: /s/date: .*/date: " ..
    \ strftime("%Y-%m-%d")
    exe "1," .. l .. "g/title: /s/title: .*/title: " ..
    \ expand('%:t:r')
    exe "1," .. l .. "g/# /s/# .*/# " ..
    \ expand('%:t:r')
  endfun
]]

vim.cmd [[
  autocmd BufWritePre,FileWritePre *.md   ks|call LastMod()|'s
  fun LastMod()
    if line("$") > 20
      let l = 20
    else
      let l = line("$")
    endif
    exe "1," .. l .. "g/lastmod: /s/lastmod: .*/lastmod: " ..
    \ strftime("%Y-%m-%d")
  endfun
]]

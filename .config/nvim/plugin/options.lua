-- :help options

vim.opt.termguicolors = true -- True colour support

vim.opt.mouse = "a" -- Mouse support

-- Attempt to determine the type of a file based on its name and possibly its
-- contents. Use this to allow intelligent auto-indenting for each file type,
-- and for plugins that are file type specific
--filetype plugin indent on

-- This adds the current directory to the :Find files feature (in-built)
-- Provides tab-completion for all file-related tasks
vim.opt.path:append "**"
--"set dictionary+=/usr/share/dict/words

-- This stops Vim from redrawing the screen during complex operations and
-- results in much smoother looking plugins
vim.opt.lazyredraw = true

-- No swap and No backup files
vim.opt.swapfile = false -- Don't create swap files for new buffers
vim.opt.backup = false -- Don't use backup files
vim.opt.writebackup = false -- Don't backup the file while editing
vim.opt.updatecount = 0 -- Don't try to write swap files after some number of updates

vim.opt.hlsearch = true -- Highlight searches
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case-sensitive search
vim.opt.incsearch = true
vim.opt.title = true

-- The same indent as the line you're currently on. Useful for README, etc.
vim.opt.autoindent = true
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.breakindent = true

--vim.opt.expandtab = true
--vim.opt.tabstop = 4 -- Number of spaces tabs count for
--vim.opt.softtabstop = 4 -- Insert mode tab and backspace use 4 spaces
--vim.opt.shiftwidth = 4 -- Normal mode indentation commands use 4 spaces
--vim.opt.shiftround = true -- Round indent to a multiple of `shiftwidth`

vim.opt.foldenable = false -- Do not fold on file opening

vim.opt.scrolloff = 10 -- Lines of context
vim.opt.sidescrolloff = 10 -- Columns of context

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

-- Show "invisible" characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "❯", precedes = "❮" }
vim.opt.showbreak = "↪"

vim.wo.relativenumber = true -- Relative line numbers
vim.wo.number = true -- Line numbering

vim.opt.showmode = false -- Don't show mode since we have a status line

vim.opt.autoread = true -- Auto Read if file updated externally

vim.opt.cursorline = true -- Enable highlighting of the current line

vim.schedule(function()
  -- vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
  vim.opt.clipboard = ""
end)

vim.opt.spell = true
vim.opt.spelllang = "en_gb"

-- Autocomplete with dictionary words when spell check is on
-- opt.complete:append "kspell"
-- opt.dictionary:append "/usr/share/dict/words"
-- opt.thesaurus:append "~/Thesaurus/english.txt"

-- Set completeopt to have better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Wildmode Options
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode (list matches, then longest common part, then all)

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
-- Rust
vim.opt.wildignore:append { "Cargo.lock", "Cargo.Bazel.lock" }

--"set showtabline=2 -- Always show tabs

--"set exrc -- Source .vimrc present in the project directory

vim.opt.inccommand = "split" -- Show live replace
vim.opt.matchpairs:append { "<:>" }
vim.opt.updatetime = 100 -- Faster completion
vim.opt.timeoutlen = 300
vim.wo.signcolumn = "yes"

vim.opt.iskeyword:append { "-" } -- Consider words split by '-' as one

--vim.g.python3_host_prog = '/usr/bin/python3'    --Python 3 provider (optional)
-- Disable providers we do not care a about
--vim.g.loaded_python_provider  = 0
--vim.g.loaded_ruby_provider    = 0
--vim.g.loaded_perl_provider    = 0
--vim.g.loaded_node_provider    = 0

--opt.formatoptions = "jcroqlnt" -- `tcgj`
vim.opt.formatoptions = vim.opt.formatoptions
  + "c" -- Comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  - "r" -- Don't insert comment after <Enter>
  + "n" -- Indent past the formatlistpat, not underneath it
  + "j" -- Auto-remove comments if possible
  - "2" -- Not in gradeschool anymore
  + "l" -- Long lines are not broken in insert mode
-- - "a" -- Auto formatting is BAD
-- - "t" -- Don't auto format my code. Linters can do that
-- Don't have `o` add a comment
-- opt.formatoptions:remove "o"

if vim.fn.executable "rg" then
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.opt.grepprg = "rg --vimgrep --no-heading"
end

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.splitkeep = "screen" -- Reduce scroll during window split

vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- Don't highlight long lines
vim.opt.synmaxcol = 250

-- Add custom filetypes
--vim.filetype.add { extension = { templ = "templ" } }

vim.opt.smoothscroll = true

vim.opt.confirm = true -- Confirm before closing unsaved buffers

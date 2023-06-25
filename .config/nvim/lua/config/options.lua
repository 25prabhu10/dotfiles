-- :help options

local opt = vim.opt

opt.termguicolors = true -- True color support

opt.mouse = "a" -- Mouse support

-- Attempt to determine the type of a file based on its name and possibly its
-- contents. Use this to allow intelligent auto-indenting for each file type,
-- and for plugins that are file type specific.
--filetype plugin indent on

-- This adds the current directory to the :Find files feature (in-built)
-- Provides tab-completion for all file-related tasks
opt.path:append "**"
--"set dictionary+=/usr/share/dict/words

-- This stops Vim from redrawing the screen during complex operations and results
-- in much smoother looking plugins.
opt.lazyredraw = true

-- No swap and No backup files
opt.swapfile = false -- Don't create swap files for new buffers
opt.backup = false -- Don't use backup files
opt.writebackup = false -- Don't backup the file while editing
opt.updatecount = 0 -- Don't try to write swap files after some number of updates

-- The same indent as the line you're currently on. Useful for README, etc.
opt.autoindent = true
opt.smartindent = true -- Insert indents automatically

opt.expandtab = true
opt.tabstop = 4 -- Number of spaces tabs count for
opt.softtabstop = 4 -- Insert mode tab and backspace use 4 spaces
opt.shiftwidth = 4 -- Normal mode indentation commands use 4 spaces
opt.shiftround = true -- Round indent to a multiple of `shiftwidth`

opt.foldenable = false -- Do not fold on file opening
opt.foldmethod = "expr" -- Tree-sitter based folding
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 4 -- Columns of context

opt.wrap = false -- Disable soft wrapping

opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

-- Show "invisible" characters
opt.list = true
opt.listchars = { tab = "»·", trail = "·", nbsp = "·", extends = "❯", precedes = "❮" }
opt.showbreak = "↪"

opt.hlsearch = true -- Highlight searches
opt.ignorecase = true
opt.smartcase = true -- Case-sensitive search
opt.incsearch = true
opt.title = true

opt.relativenumber = true -- Relative line numbers
opt.number = true -- Line numbering

opt.showmode = false -- Don't show mode since we have a status line

opt.autoread = true -- Auto Read if file updated externally

opt.colorcolumn = { 80 } -- Vertical line on column 80
opt.cursorline = true -- Enable highlighting of the current line

-- opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
opt.clipboard = ""

-- Autocomplete with dictionary words when spell check is on
--set complete+=kspell
--" set dictionary+=/usr/share/dict/words
--" set thesaurus+=/home/prabhu/Thesaurus/words

-- Wildmode Options
opt.wildmenu = true
opt.wildmode = "longest:full,full" -- Command-line completion mode (list matches, then longest common part, then all)

-- Version control
opt.wildignore:append { ".hg", ".git", ".svn" }
opt.wildignore:append { "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg" }
-- compiled object files
opt.wildignore:append { "*.o", "*.obj", "*.exe", "*.dll", "*.manifest" }
-- Vim swap files
opt.wildignore:append { "*.sw?" }
-- OSX bullshit
opt.wildignore:append { "*.DS_Store" }
-- Django migrations
opt.wildignore:append { "migrations" }
-- Python byte code
opt.wildignore:append { "__pycache__", "*.pyc" }
-- Node modules
opt.wildignore:append { "node_modules" }

--"set showtabline=2 -- Always show tabs

--"set exrc -- Source .vimrc present in the project directory

opt.inccommand = "split" -- Show live replace
opt.matchpairs:append { "<:>" }
opt.updatetime = 500 -- Faster completion
opt.signcolumn = "yes"

--opt.iskeywork:append { "-" }  -- Consider words split by '-' as one

--vim.g.python3_host_prog = '/usr/bin/python3'    --Python 3 provider (optional)
-- Disable providers we do not care a about
--vim.g.loaded_python_provider  = 0
--vim.g.loaded_ruby_provider    = 0
--vim.g.loaded_perl_provider    = 0
--vim.g.loaded_node_provider    = 0

--opt.formatoptions = "jcroqlnt" -- `tcgj`
opt.formatoptions = vim.opt.formatoptions
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

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
-- opt.timeloutlen = 300

--opt.shortmess:append({ W = true, I = true, c = true })
--if vim.fn.has("nvim-0.9.0") == 1 then
--opt.splitkeep = "screen"
--opt.shortmess:append({ C = true })
--end

-- Fix markdown indentation settings
--vim.g.markdown_recommended_style = 0

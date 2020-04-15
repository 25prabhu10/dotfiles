" -----------------------------------------------------------------------------
"  Author: Prabhu K H
"  Repo: https://github.com/25prabhu10/dotfiles
" -----------------------------------------------------------------------------

" Plugins  ------------------------------------------------------------------{{{

  " Install vim-plug if it isn't there
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter *   PlugInstall --sync | source $MYVIMRC
    endif

  " Specify a directory for plugins
    call plug#begin('~/.vim/plugged')

      " Markdown Plugins
      Plug 'godlygeek/tabular'
      Plug 'plasticboy/vim-markdown'
      Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

      " File Management Plugins
      Plug 'scrooloose/nerdtree'
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

      " File History
      Plug 'mbbill/undotree'

      " File Formatting
      Plug 'Yggdroot/indentLine'

      " Find and replace from multiple files
      Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

      " A git wrapper
      Plug 'tpope/vim-fugitive'
      Plug 'Xuyuanp/nerdtree-git-plugin'

      " Comment stuff
      Plug 'tpope/vim-commentary'


      " Dim paragraphs above and below the active paragraph
      Plug 'junegunn/limelight.vim'

      " Distraction free writing
      Plug 'junegunn/goyo.vim'

      " Gruvbox theme
      " Plug 'morhetz/gruvbox
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'mhartington/oceanic-next'
      Plug 'ryanoasis/vim-devicons'

    call plug#end()

" }}}

" System Settings  ----------------------------------------------------------{{{

  " This enhances the colors reproduced
    set nocompatible
    if (has("termguicolors"))
      set termguicolors
    endif

  " This sets the different folding options depending on file type
    autocmd BufNewFile,BufRead *.py set foldmethod=indent
    autocmd BufNewFile,BufRead *.vimrc set foldmethod=marker

  " This adds the current directory to the :Find files feature (in-built)
    set path+=**
    "set dictionary+=/usr/share/dict/words

  " When new files are opened, they follow the bellow convention.
    set splitbelow
    set splitright

  " This stops Vim from redrawing the screen during complex operations and results
  " in much smoother looking plugins.
    set lazyredraw

  " The same indent as the line you're currently on. Useful for READMEs, etc.
    set autoindent
    set smartindent

    set expandtab
    set softtabstop=4 " insert mode tab and backspace use 4 spaces
    set shiftwidth=4 " normal mode indentation commands use 4 spaces
    "set shiftround

  " Show “invisible” characters
    set lcs=trail:·,
    set list
    set showbreak=↪

  " Highlight searches
    set hlsearch
    set ignorecase

  " Case-sensitive search if any caps
    set smartcase
    set incsearch
    set title

  " Enable use of the mouse for all modes - helpful for resizing buffers
    set mouse=a
    "set ttymouse=xterm2

  " Always display the status line, even if only one window is displayed
    set laststatus=2

  " Set the command window height to 2 lines, to avoid many cases of having to
  " press <Enter> to continue
    set cmdheight=2

  " Better command-line completion
    set wildmenu

    set relativenumber number
    set conceallevel=0
    set autoread
    "set shortname

  " Don’t show the intro message when starting Vim
    set shortmess=atI

  " Show partial commands in the last line of the screen
    set showcmd
    set noshowmode

  " Vertical line on column 80
    set colorcolumn=80

  " UndoTree
    nnoremap <F9> :UndotreeToggle<CR>

    if has("persistent_undo")
      set undodir=~/.vim/tmp/undo/
      set undofile
    endif
    set backupdir=~/.vim/tmp/backup/
    set directory=~/.vim/tmp/swap/
    set backupskip=/tmp/*,/private/tmp/*"
    set backup
    set writebackup
    set swapfile
    set history=500
    set undolevels=700
    set undoreload=700

    " Make those folders automatically if they don't already exist.
    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
    if !isdirectory(expand(&backupdir))
        call mkdir(expand(&backupdir), "p")
    endif
    if !isdirectory(expand(&directory))
        call mkdir(expand(&directory), "p")
    endif

  " Wildmode Options
    set wildmenu
    " Command <Tab> completion, list matches, then longest common part, then all
    set wildmode=list:longest,full
    " Version control
    set wildignore+=.hg,.git,.svn
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
    " compiled object files
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
    " Vim swap files
    set wildignore+=*.sw?
    " OSX bullshit
    set wildignore+=*.DS_Store
    " Django migrations
    set wildignore+=migrations
    " Python byte code
    set wildignore+=*.pyc

" }}}

" System mappings  ----------------------------------------------------------{{{

  " Remap leader key
    let mapleader=','

  " Spelling Check
    nnoremap <F8> :set spell!<CR>

  " Shortcuts using <leader>
    nnoremap <leader>sn ]s
    nnoremap <leader>sp [s
    nnoremap <leader>sa zg
    nnoremap <leader>s? z=

    nnoremap ; :

    noremap H ^
    noremap L g_
    noremap J 5j
    noremap K 5K

  " Folds
    nnoremap <Space> za
    vnoremap <Space> za

  " Change tabs
    nmap <leader>. :bnext<CR>

  " Navigate around splits
    nnoremap <C-h> <C-w><C-h>
    nnoremap <C-j> <C-w><C-j>
    nnoremap <C-k> <C-w><C-k>
    nnoremap <C-l> <C-w><C-l>

  " Cycle through splits
    nnoremap <S-Tab> <C-w>w

  ""These are mainly for python
  " maps sorting lines with alphabets
    vnoremap <leader>s :sort<CR>

  " indent a code block
    vnoremap < <gv
    vnoremap > >gv

  " Save
    nnoremap <C-s> :w<CR>

  " Find
    nnoremap <C-f> /
    nnoremap f ?

  " Clear search highlights
    map <leader><Space> <Esc>:let @/=''<CR>

  " autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
    "au InsertLeave * match ExtraWhitespace /\s\+$/

" }}}

" scrooloose/nerdtree -------------------------------------------------------{{{

  nnoremap <c-o> :NERDTreeToggle<CR>

  let g:NERDTreeMouseMode = 3
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeIgnore = ['\.pyc$', '\~$', '\.jpeg$', '\.png$', '\.jpg$', '\.gif$', '\.tif$', '\.mp4$']

  let g:NERDTreeHijackNetrw=0

  let g:netrw_liststyle = 3
  let g:netrw_banner = 0

  let g:NERDTreeDirArrowExpandable = ''
  let g:NERDTreeDirArrowCollapsible = '▼'

" }}}

" junegunn/fzf.vim ----------------------------------------------------------{{{

  " Find Files
    nnoremap <leader>f <Esc>:FZF -m<CR>

" }}}

" vim-devicons --------------------------------------------------------------{{{

  let g:NERDTreeGitStatusNodeColorization = 1
  let g:webdevicons_enable_denite = 0
  "let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:WebDevIconsOS = 'Darwin'
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  "let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''

" }}}

" vim-airline ---------------------------------------------------------------{{{

  let g:webdevicons_enable_airline_statusline = 1

  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif

  let g:airline_theme = 'oceanicnext'
  let g:airline_powerline_fonts = 1

" Unicode symbols
"  let g:airline_left_sep = '»'
"  let g:airline_left_sep = '▶'
"  let g:airline_right_sep = '«'
"  let g:airline_right_sep = '◀'
"  let g:airline_symbols.linenr = '␊'
"  let g:airline_symbols.linenr = '␤'
"  let g:airline_symbols.linenr = '¶'
"  let g:airline_symbols.branch = '⎇'
"  let g:airline_symbols.paste = 'ρ'
"  let g:airline_symbols.paste = 'Þ'
"  let g:airline_symbols.paste = '∥'
"  let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"  let g:airline_left_sep = ''
"  let g:airline_left_alt_sep = ''
"  let g:airline_right_sep = ''
"  let g:airline_right_alt_sep = ''
"  let g:airline_symbols.branch = ''
"  let g:airline_symbols.readonly = ''
"  let g:airline_symbols.linenr = ''

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#whitespace#enabled = 0
  "let g:airline_section_c = '%f%m'

  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" }}}

" plasticboy/vim-markdown ---------------------------------------------------{{{

  " Disable Folding
  let g:vim_markdown_folding_disabled = 1

  " Enable TOC window auto-fit
  let g:vim_markdown_toc_autofit = 1

  " Disable Syntax Concealing
  let g:vim_markdown_conceal = 0

" }}}

" iamcco/markdown-preview.nvim ----------------------------------------------{{{

  let g:mkdp_refresh_slow=1
  let g:mkdp_markdown_css='/home/prabhu/.local/lib/github-markdown-css/github-markdown.css'
" }}}

" Themes, Commands, etc -----------------------------------------------------{{{

  " Enable syntax highlighting
    syntax on

  " Attempt to determine the type of a file based on its name and possibly its
  " contents. Use this to allow intelligent auto-indenting for each filetype,
  " and for plugins that are filetype specific.
    filetype plugin indent on

    let g:one_allow_italics = 1
    let g:oceanic_next_terminal_bold = 1
    let g:oceanic_next_terminal_italic = 1
    colorscheme OceanicNext 
    hi CursorLineNr guifg=#ffffff

"}}}

" Copy dotfiles -------------------------------------------------------------{{{

  " Copy dotfiles to dropbox on save
  autocmd BufWritePost .bashrc,.gitconfig,.profile,.vimrc !~/Scripts/copydotfiles.sh <afile>

" }}}

" Limit Commit Words --------------------------------------------------------{{{

  autocmd Filetype gitcommit setlocal spell textwidth=72

" }}}

" NOTES  --------------------------------------------------------------------{{{

" Use vim -b file while opening binary files or use :set binary

"""Enable per-directory .vimrc files and disable unsafe commands in them
  "set exrc
  "set secure

" }}}

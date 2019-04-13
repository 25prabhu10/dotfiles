"
"  Author: Prabhu K H
"  repo  : https://github.com/25prabhu10/dotfiles
"
" Plugins  ------------------------------------------------------------------{{{

" Install vim-plug if it isnt there
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter *   PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.vim/plugged')

""  Untils
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    Plug 'mbbill/undotree'
    Plug 'Yggdroot/indentLine'

    Plug 'tpope/vim-fugitive'
    Plug 'Xuyuanp/nerdtree-git-plugin'

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

  set expandtab
  set softtabstop=4 " insert mode tab and backspace use 4 spaces
  set shiftwidth=4 " normal mode indentation commands use 4 spaces
  "set shiftround

" Show “invisible” characters
  set lcs=trail:·,
  set list

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

  let mapleader=','

" UndoTree
  nnoremap <F9> :UndotreeToggle<CR>

  if has("persistent_undo")
    set undodir=~/.vim/tmp/undo//
    set undofile
  endif
  set backupdir=~/.vim/tmp/backup//
  set directory=~/.vim/tmp/swap//
  set backupskip=/tmp/*,/private/tmp/*"
  set backup
  set writebackup
  set swapfile
  set history=500
  set undolevels=700
  set undoreload=700

" }}}

" System mappings  ----------------------------------------------------------{{{

" Spelling Check
  nnoremap <F8> :set spell!<CR>

  noremap H ^
  noremap L g_
  nnoremap ; :

  nnoremap <Space> za
  vnoremap <Space> za

  nmap <leader>. :bnext<CR>
  nmap <leader>, :bprevious<CR>

  nnoremap <C-h> <C-w><C-h>
  nnoremap <C-j> <C-w><C-j>
  nnoremap <C-k> <C-w><C-k>
  nnoremap <C-l> <C-w><C-l>


""These are mainly for python
" maps sorting lines with alphabets
  vnoremap <leader>s :sort<CR>

" indent a code block
  vnoremap < <gv
  vnoremap > >gv

  "autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
  "au InsertLeave * match ExtraWhitespace /\s\+$/

"}}}

" NERDTree ------------------------------------------------------------------{{{

  nnoremap <c-o> :NERDTreeToggle<CR>

  let g:NERDTreeMouseMode = 3
  let NERDTreeShowHidden = 1
  let NERDTreeIgnore = ['\.pyc$', '\~$', '\.jpeg$', '\.png$', '\.jpg$', '\.gif$', '\.tif$', '\.mp4$']

  let NERDTreeHijackNetrw=0

  let g:netrw_liststyle = 3
  let g:netrw_banner = 0

  let g:NERDTreeDirArrowExpandable = ''
  let g:NERDTreeDirArrowCollapsible = '▼'

"}}}

" Vim-Devicons --------------------------------------------------------------{{{

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
  "let g:airline_powerline_fonts = 0
  let g:airline_powerline_fonts = 1

" unicode symbols
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

"}}}

" Themes, Commands, etc ----------------------------------------------------{{{

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

" NOTES  ----------------------------------------------------{{{

" Use vim -b file while opening binary files or use :set binary

"""Enable per-directory .vimrc files and disable unsafe commands in them
  "set exrc
  "set secure

"}}}

" -----------------------------------------------------------------------------
"  Author: Prabhu K H
"  Repo: https://github.com/25prabhu10/dotfiles
" -----------------------------------------------------------------------------

" Plugins  ------------------------------------------------------------------{{{

  call plug#begin('~/.config/nvim/plugged')

    " Git wrappers
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " color scheme
    Plug 'joshdick/onedark.vim'

    " Status line
    Plug 'itchyny/lightline.vim'

  call plug#end()

" }}}

" Settings ------------------------------------------------------------------{{{

  " This adds the current directory to the :Find files feature (in-built)
    set path+=**
    "set dictionary+=/usr/share/dict/words

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

  " File split will follow the bellow convention.
    set splitbelow
    set splitright

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

  " Line numbering
    set relativenumber number

  " Auto Read if file updated externally
    set autoread

  " Vertical line on column 80
    set colorcolumn=80

  " Enable highlighting of the current line
    set cursorline

  " Copy paste between vim and everything else
    set clipboard=unnamedplus

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

  " Always show tabs
    " set showtabline=2

" }}}

" Function-------------------------------------------------------------------{{{

  " This sets the different folding options depending on file type
    autocmd BufNewFile,BufRead *.py set foldmethod=indent
    autocmd BufNewFile,BufRead *.vimrc,*.vim set foldmethod=marker

" }}}

" Mappings  -----------------------------------------------------------------{{{

  " Remap leader key
    let mapleader=','

  " Spelling Check
    nnoremap <F8> :set spell!<CR>

  " Folds
    nnoremap <Space> za
    vnoremap <Space> za

  " Navigate around splits
    nnoremap <C-h> <C-w><C-h>
    nnoremap <C-j> <C-w><C-j>
    nnoremap <C-k> <C-w><C-k>
    nnoremap <C-l> <C-w><C-l>

  " Clear search highlights
    map <leader><Space> <Esc>:let @/=''<CR>

" }}}

" Lightline -----------------------------------------------------------------{{{

  let g:lightline = {
               \ 'colorscheme': 'onedark',
               \ 'active': {
               \ 'left': [ [ 'mode', 'paste' ],
               \    [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
               \ },
               \ 'component_function': {
               \    'readonly': 'LightlineReadonly',
               \    'gitbranch': 'LightlineFugitive'
               \ },
               \ }
  function! LightlineReadonly()
      return &readonly ? '' : ''
  endfunction
  function! LightlineFugitive()
      if exists('*FugitiveHead')
          let branch = FugitiveHead()
          return branch !=# '' ? ''.branch : ''
      endif
      return ''
  endfunction

  let g:lightline.separator = {
               \ 'left': '', 'right': ''
               \ }
 
  let g:lightline.subseparator = {
               \ 'left': '', 'right': ''
               \ }

" }}}

" Themes --------------------------------------------------------------------{{{

  " Attempt to determine the type of a file based on its name and possibly its
  " contents. Use this to allow intelligent auto-indenting for each filetype,
  " and for plugins that are file type specific.
    filetype plugin indent on

  " Color Schema
    hi Comment cterm=italic
    let g:onedark_hide_endofbuffer=1
    let g:onedark_terminal_italics=1
    let g:onedark_termcolors=256

  " Enable syntax highlighting
    syntax on
    colorscheme onedark

  " Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
    if (empty($TMUX))
	    if (has("nvim"))
		    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	    endif
	    if (has("termguicolors"))
		    set termguicolors
	    endif
    endif

"}}}

" Copy dotfiles -------------------------------------------------------------{{{

  " Copy dotfiles to dropbox on save
  autocmd BufWritePost .bashrc,.gitconfig,.profile,.vimrc,init.vim !~/Scripts/copydotfiles.sh <afile>

" }}}

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

    Plug 'scrooloose/nerdtree'
    Plug 'mbbill/undotree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'

  call plug#end()
" }}}

" System Settings  ----------------------------------------------------------{{{

  set nocompatible
  filetype plugin indent on
  syntax on

  set autoindent
  set expandtab
  set softtabstop =4
  set shiftwidth  =4
  "set shiftround

  set hlsearch
  set ignorecase
  set smartcase
  set incsearch
  set title

  set mouse=a
  "set ttymouse=xterm2
  set laststatus=2
  set cmdheight=2
  set wildmenu

  set relativenumber number
  set foldmethod=marker

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

"}}}

" NERDTree ------------------------------------------------------------------{{{

  nnoremap <c-o> :NERDTreeToggle<CR>

  let g:NERDTreeMouseMode = 3
  let NERDTreeShowHidden = 1
  let NERDTreeIgnore = ['\.pyc$', '\~$']
  " let g:NERDTreeChDirMode=2

  if !exists("g:airline_symbols")
    let g:airline_symbols = {}
  endif

"}}}

" Vim-Devicons --------------------------------------------------------------{{{

  let g:NERDTreeGitStatusNodeColorization = 1
  let g:webdevicons_enable_denite = 0
  let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:WebDevIconsOS = 'Darwin'
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
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

  let g:airline_theme = 'powerlineish'
  let g:airline_powerline_fonts = 0
  "let g:airline_powerline_fonts = 1

" unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline_section_c = '%f%m'

  let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

"}}}

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
    Plug 'mbbill/undotree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mhartington/oceanic-next'
    Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'

  call plug#end()
" }}}

" System Settings  ----------------------------------------------------------{{{

  set nocompatible
  filetype on "plugin indent on
  syntax on
  if (has("termguicolors"))
    set termguicolors
  endif

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
  set pastetoggle=<F6>
  set conceallevel=0
  set autoread
  "set shortname

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

"}}}

" NERDTree ------------------------------------------------------------------{{{

  nnoremap <c-o> :NERDTreeToggle<CR>

  let g:NERDTreeMouseMode = 3
  let NERDTreeShowHidden = 1
  let NERDTreeIgnore = ['\.pyc$', '\~$']
  " let g:NERDTreeChDirMode=2

""  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
""  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .'guibg='. a:guibg .' guifg='. a:guifg
""  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
""  endfunction

""  call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
""  call NERDTreeHighlightFile('md', 'blue', 'none', '#6699CC', 'none')
""  call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
""  call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
""  call NERDTreeHighlightFile('ison', 'green', 'none', '#d8a235', 'none')
""  call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
""  call NERDTreeHighlightFile('css', 'cyan', 'none', '#5486C0', 'none')
""  call NERDTreeHighlightFile('scss', 'cyan', 'none', '#5486C0', 'none')
""  call NERDTreeHighlightFile('coffee', 'red', 'none', 'red', 'none')
""  call NERDTreeHighlightFile('js', 'red', 'none', '#ffa500', 'none')
""  call NERDTreeHighlightFile('ts', 'blue', 'none', '#6699cc', 'none')
""  call NERDTreeHighlightFile('ds_store', 'gray', 'none', '#686868', 'none')
""  call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
""  call NERDTreeHighlightFile('gitignore', 'gray', 'none', '#7F7F7F', 'none')

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
  "let g:airline_section_c = '%f%m'

  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

"}}}

" Themes, Commands, etc  ----------------------------------------------------{{{

  syntax on
  let g:one_allow_italics = 1
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  colorscheme OceanicNext 
  hi CursorLineNr guifg=#ffffff

"}}}

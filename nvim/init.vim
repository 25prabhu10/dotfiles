" -----------------------------------------------------------------------------
"  Author: Prabhu K H
"  Repo: https://github.com/25prabhu10/dotfiles
" -----------------------------------------------------------------------------

" Plugins  ------------------------------------------------------------------{{{

  " Download Vim-Plug if not present
    let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')

    if !filereadable(vimplug_exists)
        if !executable("curl")
            echoerr "You have to install curl or first install vim-plug yourself!"
            execute "q!"
        endif
        echo "Installing Vim-Plug..."
        echo ""
        silent exec "!\curl -flo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        let g:not_finish_vimplug="yes"

        autocmd VimEnter * PlugInstall
    endif

  " Plugins directory
    call plug#begin('~/.config/nvim/plugged')

    " Startup view
      Plug 'mhinz/vim-startify'

    " File History
      Plug 'mbbill/undotree'

    " Fuzzy finder
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'

    " Git wrappers
      Plug 'tpope/vim-fugitive'
      " Plug 'airblade/vim-gitgutter'

    " Dim paragraphs above and below the active paragraph
      Plug 'junegunn/limelight.vim', { 'on': ['Limelight', 'Goyo'] }

    " Distraction free writing
      Plug 'junegunn/goyo.vim', { 'on': ['Limelight', 'Goyo'] }

    " Markdown Plugins
      Plug 'godlygeek/tabular', { 'for': 'markdown' }
      Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

    " Linter
      Plug 'dense-analysis/ale'

    " Color scheme
      Plug 'chriskempson/base16-vim' " fall-back color scheme
      Plug 'joshdick/onedark.vim'

    " Status line
      Plug 'itchyny/lightline.vim'

    call plug#end()

" }}}

" Settings ------------------------------------------------------------------{{{

  " Non-compatible with VI
    if &compatible
        set nocompatible
    end

  " This adds the current directory to the :Find files feature (in-built)
    set path+=**
    "set dictionary+=/usr/share/dict/words

  " This stops Vim from redrawing the screen during complex operations and results
  " in much smoother looking plugins.
    set lazyredraw

  " No swap and No backup files
    set noswapfile " don't create swapfiles for new buffers
    set nobackup " don't use backup files
    set nowritebackup " don't backup the file while editing
    set updatecount=0 " don't try to write swap files after some number of upda

  " The same indent as the line you're currently on. Useful for READMEs, etc.
    set autoindent
    set smartindent

    set expandtab
    set tabstop=4
    set softtabstop=4 " insert mode tab and backspace use 4 spaces
    set shiftwidth=4 " normal mode indentation commands use 4 spaces
    "set shiftround " round indent to a multiple of 'shiftwidth'

  " Do not fold on file opening
    set nofoldenable

  " Mouse support
    if has('mouse')
        set mouse=a
    endif

  " Disable soft wrapping
    set wrap

  " File split will follow the bellow convention.
    set splitbelow
    set splitright

  " Show “invisible” characters
    set list
    set listchars=tab:»·,trail:·,nbsp:·,extends:❯,precedes:❮
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

  " Autocomplete with dictionary words when spell check is on
    set complete+=kspell
    " set dictionary+=/usr/share/dict/words
    " set thesaurus+=/home/prabhu/Thesaurus/words

  " Wildmode Options
    set wildmenu
    " Command <Tab> completion, list matches, then longest common part, then all
    set wildmode=list:longest,list:full
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

  " Show live replace
    if (has('nvim'))
        " show results of substition as they're happening
        set inccommand=split
    endif

" }}}

" Function-------------------------------------------------------------------{{{

  augroup configgroup
      autocmd!
      " When editing a file, always jump to the last known cursor position.
      " Don't do it for commit messages, when the position is invalid, or when
      " inside an event handler (happens when dropping a file on gvim).
      autocmd BufReadPost *
                  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal g`\"" |
                  \ endif

      " Set syntax highlighting for specific file types
      autocmd BufRead,BufNewFile *.md set filetype=markdown
      autocmd BufRead,BufNewFile .{jscs,jshint,eslint,babel}rc set filetype=json
      autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
      autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
      autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  augroup END

  " This sets the different folding options depending on file type
    autocmd BufNewFile,BufRead *.py set foldmethod=indent
    autocmd BufNewFile,BufRead *.vimrc,*.vim set foldmethod=marker

  " remove trailing whitespace
    command! FixWhitespace :%s/\s\+$//e

" }}}

" Mappings  -----------------------------------------------------------------{{{

  " Remap leader key
    let mapleader=','

  " Cursor movement when word wrap is on
    nnoremap <silent> k gk
    nnoremap <silent> j gj

  " Move lines
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    inoremap <A-j> <Esc>:m .+1<CR>==gi
    inoremap <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv

  " Shortcut to save
    nnoremap <Leader>s :w<cr>

  " Spelling Check
    nnoremap <F8> :set spell!<CR>

  " Switch between the last two files
    nnoremap <Leader><Leader> <C-^>

  " Folds
    nnoremap <Space> za
    vnoremap <Space> za

  " Spell bindings
    nnoremap <leader>sn ]s
    nnoremap <leader>sp [s
    nnoremap <leader>sa zg
    nnoremap <leader>s? z=

  " Navigate around splits
    nnoremap <C-h> <C-w><C-h>
    nnoremap <C-j> <C-w><C-j>
    nnoremap <C-k> <C-w><C-k>
    nnoremap <C-l> <C-w><C-l>

  " Clear search highlights
    map <leader><Space> <Esc>:let @/=''<CR>

  " Split
    noremap <Leader>h :<C-u>split<CR>
    noremap <Leader>v :<C-u>vsplit<CR>

  " Increase and decrease split width
    nnoremap <Leader>+ :vertical resize +5<CR>
    nnoremap <Leader>- :vertical resize -5<CR>

  " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

" }}}

" Netrw  --------------------------------------------------------------------{{{

  " Remove banner
    let g:netrw_banner=0

  " Folders list style
    let g:netrw_liststyle=3

  " Split size
    let g:netrw_winsize=20

  " Open files in new tab
    let g:netrw_browse_split=2

" }}}

" UndoTree  -----------------------------------------------------------------{{{

  if has("persistent_undo")
      set undodir=~/.local/share/nvim/undodir
      set undofile
  endif
  set history=500
  set undolevels=700
  set undoreload=700

  " UndoTree toggle
    nnoremap <F9> :UndotreeToggle<CR>

" }}}

" Fsickill/vim-pastaZF.vim ----------------------------------------------------------{{{

  " Search word in in multiple files
    nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
    nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>

  " FZF pop up window
    if isdirectory(".git")
        " if in a git project, use :GFiles
        nnoremap <leader>f <Esc>:GitFiles --cached --others --exclude-standard<CR>
    else
        " otherwise, use :FZF
        nnoremap <leader>f <Esc>:FZF -m<CR>
    endif

  " Show modified files
    nmap <silent> <leader>s :GFiles?<cr>

  " Buffers
    nnoremap <leader>b :Buffers<CR>

    " let $FZF_DEFAULT_COMMAND =  \"find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
    " " let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
    " " let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    " " function! FloatingFZF()
    " " let buf = nvim_create_buf(v:false, v:true)
    " " call setbufvar(buf, '&signcolumn', 'no')
    " " let height = float2nr(10)
    " " let width = float2nr(80)
    " " let horizontal = float2nr((&columns - width) / 2)
    " " let vertical = 1
    " " let opts = {
    " " \ 'relative': 'editor',
    " " \ 'row': vertical,
    " " \ 'col': horizontal,
    " " \ 'width': width,
    " " \ 'height': height,
    " " \ 'style': 'minimal'
    " " \ }
    " " call nvim_open_win(buf, v:true, opts)
    " " endfunction

" }}}

" Lightline -----------------------------------------------------------------{{{

  let g:lightline = {
               \ 'colorscheme': 'onedark',
               \ 'active': {
               \ 'left': [ [ 'mode', 'paste' ],
               \    [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
               \  },
               \ 'component_function': {
               \    'readonly': 'LightlineReadonly',
               \    'gitbranch': 'LightlineFugitive'
               \  },
               \ }
  function! LightlineReadonly()
      return &readonly ? '' : ''
  endfunction
  function! LightlineFugitive()
      if exists('*FugitiveHead')
          let branch = FugitiveHead()
          return branch !=# '' ? ' '.branch : ''
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

" Limelight -----------------------------------------------------------------{{{

  " Activate Limelight
    nnoremap <Leader>l :Limelight!!<CR>

" }}}

" Goyo ----------------------------------------------------------------------{{{

  " Activate Goyo
    nnoremap <Leader>g :Goyo<CR>

" }}}

" Startify ------------------------------------------------------------------{{{

  " When Goyo is enabled, issue in opening new file.
  " https://github.com/mhinz/vim-startify/wiki/Known-issues-with-other-plugins
    autocmd BufEnter *
       \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
       \   let t:startify_new_tab = 1 |
       \   Startify |
       \ endif

  " returns all modified files of the current git repo
  " `2>/dev/null` makes the command fail quietly, so that when we are not
  " in a git repo, the list will be empty
    function! s:gitModified()
        let files = systemlist('git ls-files -m 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
    endfunction
    " same as above, but show untracked files, honouring .gitignore
    function! s:gitUntracked()
        let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
    endfunction
    let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   Recent Files']            },
        \ { 'type': 'dir',       'header': ['   Directory: '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

" }}}

" Vim-Markdown --------------------------------------------------------------{{{

  " Enable TOC window auto-fit
    let g:vim_markdown_toc_autofit=1

  " Disable Syntax Concealing
    let g:vim_markdown_conceal=0

  " Disable folding by default
    let g:vim_markdown_folding_disabled=1

" }}}

" ALE -----------------------------------------------------------------------{{{

  " Lint Only Specific File Formats
  let g:ale_linters_explicit = 1
  " Stop Linting On File Open
  let g:ale_lint_on_enter = 0
  " Format On Save
  let g:ale_fix_on_save = 1
  let g:ale_sign_error = '●'
  let g:ale_sign_warning = '.'
  let b:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}

  " Lint
  nnoremap <S-A-l> :ALELint<CR>
  " Format Document
  nnoremap <S-A-f> :ALEFix<CR>


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

    let base16colorspace=256 " 256 color support for base-16

  " Enable syntax highlighting
    syntax on
    colorscheme onedark

  " Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"    if (empty($TMUX))
"	    if (has("nvim"))
"		    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"	    endif
	if (has("termguicolors"))
        set termguicolors
    endif

"}}}

" Copy dotfiles -------------------------------------------------------------{{{

  " Copy dotfiles to dropbox on save
  " autocmd BufWritePost .bashrc,.gitconfig,.profile,.vimrc,init.vim,*.zsh* !~/Scripts/copydotfiles.sh <afile>

" }}}

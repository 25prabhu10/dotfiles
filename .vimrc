"***************************************************************
"		Initialization
"***************************************************************

set nocompatible


"***************************************************************
"		Plugins - Vundle
"***************************************************************

" Install vim-plug if it isnt there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter *   PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

  Plug 'scrooloose/nerdtree'
    let g:NERDTreeMouseMode=3
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['\.pyc$', '\~$']

  Plug 'mbbill/undotree'

call plug#end()


"***************************************************************
"		Settings
"***************************************************************

""""""""""UndoTree""""""""""
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

nnoremap <F9> :UndotreeToggle<CR>

""""""""""NERDTree""""""""""
nnoremap <c-o> :NERDTreeToggle<CR>

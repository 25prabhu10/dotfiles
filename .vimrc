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

call vundle#end()

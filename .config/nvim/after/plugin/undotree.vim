" UndoTree Plugin Settings

if has("persistent_undo")
    let target_path=expand("~/.local/share/nvim/undodir")

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

set history=500
set undolevels=700
set undoreload=700

" UndoTree toggle
nnoremap <F5> :UndotreeToggle<CR>

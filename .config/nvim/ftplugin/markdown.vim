" let g:ale_linters = {'markdown': ['textlint']}
" let b:ale_fixers = {'markdown': ['prettier']}

" let g:ale_textlint_executable = '/run/media/prabhu/Vinayak/Text/Ubuntu/notes/node_modules/.bin/textlint'
" let g:ale_javascript_prettier_executable = '/run/media/prabhu/Vinayak/Text/Ubuntu/notes/node_modules/.bin/prettier'

" let g:ale_textlint_options = '-c /run/media/prabhu/Vinayak/Text/Ubuntu/notes/.textlintrc'

setlocal wrap
setlocal suffixesadd+=.md
setlocal conceallevel=0

let g:markdown_fenced_languages = ['c', 'cpp', 'javascript', 'jsx=javascriptreact', 'html', 'css', 'bash=sh', 'python', 'sql', 'json', 'scss', 'csharp=cs']

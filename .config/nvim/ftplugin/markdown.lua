--let g:ale_linters = {'markdown': ['textlint']}
--let b:ale_fixers = {'markdown': ['prettier']}

--let g:ale_textlint_executable = '/run/media/prabhu/Vinayak/Text/Ubuntu/notes/node_modules/.bin/textlint'
--let g:ale_javascript_prettier_executable = '/run/media/prabhu/Vinayak/Text/Ubuntu/notes/node_modules/.bin/prettier'

--let g:ale_textlint_options = '-c /run/media/prabhu/Vinayak/Text/Ubuntu/notes/.textlintrc'

vim.opt_local.wrap = true
vim.opt_local.suffixesadd:append ".md"
vim.opt_local.conceallevel = 0
vim.opt_local.spell = true
--vim.opt_local.textwidth = 80

vim.g.markdown_fenced_languages =
  { "c", "cpp", "javascript", "typescript", "jsx=javascriptreact", "html", "css", "bash=sh", "python", "sql", "json", "scss", "csharp=cs" }

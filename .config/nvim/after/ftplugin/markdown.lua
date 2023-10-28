vim.opt_local.wrap = true
vim.opt_local.suffixesadd:append ".md"
vim.opt_local.conceallevel = 0
vim.opt_local.spell = true
vim.opt_local.shiftwidth = 2
-- vim.opt_local.textwidth = 80

-- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0
-- if get(g:, 'markdown_recommended_style', 1)
--   setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
-- endif

vim.g.markdown_fenced_languages = {
  "c",
  "cpp",
  "javascript",
  "typescript",
  "jsx=javascriptreact",
  "html",
  "css",
  "bash=sh",
  "python",
  "sql",
  "json",
  "scss",
  "csharp=cs",
}

vim.opt.thesaurus:append "~/Thesaurus/th_en_US.dat"

vim.openoffice = {}

function vim.openoffice.thesaurusfunc(findstart, base)
  if findstart == 1 then
    local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
    return vim.fn.match(line:sub(1, col), "\\k*$")
  end

  local completions, term = {}, base:lower() .. "|"
  for _, file in ipairs(vim.opt.thesaurus:get()) do
    file = vim.fn.expand(file)
    if vim.fn.filereadable(file) == 1 then
      local iterator = io.lines(file)
      iterator() -- skip first line
      for line in iterator do
        if vim.startswith(line, term) then
          for _ = 1, tonumber(line:sub(#term + 1)) do
            local synonyms = vim.split(iterator(), "|")
            local pos = table.remove(synonyms, 1)
            for _, synonym in ipairs(synonyms) do
              -- remove additional information for to be inserted word which is often given in parentheses
              local insert = vim.trim(synonym:gsub("%(.-%)", ""):gsub(" +", " "))
              if insert ~= base then
                table.insert(completions, {
                  abbr = synonym,
                  word = insert,
                  menu = not vim.tbl_contains({ "-", "" }, pos) and (pos:match "^%((.+)%)$" or pos) or nil,
                })
              end
            end
          end
        end
      end
    end
  end

  return completions
end

vim.opt.thesaurusfunc = "v:lua.vim.openoffice.thesaurusfunc"

-- function ThesaurusLookup(word)
--   local thesaurus_file = vim.fn.expand "~/Thesaurus/th_en_US.dat"
--   local thesaurus_cmd = string.format('grep -w "^%s" %s', word, thesaurus_file)
--   local thesaurus_output = vim.fn.system(thesaurus_cmd)
--
--   if vim.v.shell_error ~= 0 then
--     print "Error: Thesaurus not available."
--     return ""
--   end
--
--   local lines = vim.split(thesaurus_output, "\n")
--   local synonyms = {}
--   for _, line in ipairs(lines) do
--     local parts = vim.split(line, "|")
--     if #parts > 1 then
--       table.insert(synonyms, parts[2])
--     end
--   end
--
--   if #synonyms == 0 then
--     return "No synonyms found for " .. word
--   else
--     return table.concat(synonyms, ", ")
--   end
-- end
--
-- vim.api.nvim_set_option("completefunc", "v:lua.ThesaurusLookup")

-- function Thesaur(findstart, base)
--   if findstart then
--     return vim.fn.searchpos("<", "bnW", vim.fn.line ".")[1] - 1
--   end
--
--   local res = {}
--   local h = ""
--   for _, l in ipairs(vim.fn.systemlist("aiksaurus " .. vim.fn.shellescape(base))) do
--     if vim.startswith(l, "=== ") then
--       h = "(" .. string.match(l, "=== (.-)%s*$") .. ")"
--     elseif l == "Alphabetically similar known words are: " then
--       h = "\\U0001f52e"
--     elseif string.match(l, "^[A-Za-z]") or (h == "\\U0001f52e" and vim.startswith(l, "\t")) then
--       local words = vim.split(vim.trim(l), ", ")
--       for _, val in ipairs(words) do
--         table.insert(res, { word = val, menu = h })
--       end
--     end
--   end
--
--   return res
-- end
--
-- vim.opt.thesaurusfunc = Thesaur

-- vim.fn['Thesaurus'] = function(word)
--     local cmd = 'sdcv -n -u "" -u "" -u "" --utf8-output ' .. word
--     local handle = io.popen(cmd)
--     local result = handle:read("*a")
--     handle:close()
--     return result
-- end
--
-- vim.o.thesaurusfunc = "v:lua.Thesaurus"

--" format JSON files using 'jq'
--command! Format execute '%!jq'
--command! Minify execute '%!jq -c'

vim.api.nvim_buf_create_user_command(0, "Format", ":%!jq", {})
vim.keymap.set("n", "<leader>fd", "<cmd>Format<cr>", { desc = "Format current buffer with LSP" })

vim.api.nvim_buf_create_user_command(0, "Minify", ":%!jq -c", {})

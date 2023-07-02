-- Format JSON files using 'jq'
vim.keymap.set("n", "<leader>fd", "<cmd>%!jq<cr>", { desc = "Format current buffer with LSP" })

vim.api.nvim_buf_create_user_command(0, "Minify", ":%!jq -c", {})

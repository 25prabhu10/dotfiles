-- Compile the current C file with clang and run it. Map it to <leader>r
vim.api.nvim_set_keymap("n", "<leader>cr", ":!make && ./bin/main<CR>", { noremap = true, silent = true })

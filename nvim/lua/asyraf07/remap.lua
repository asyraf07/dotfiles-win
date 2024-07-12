-- Netrw keymap
-- vim.keymap.set("n", "<leader>ph", vim.cmd.Ex)

vim.keymap.set("n", "<leader><leader>", ":so<CR>")

vim.keymap.set("n", "s", "<C-w>")

vim.keymap.set("n", "<F3>", ":set hlsearch!<CR>")

vim.keymap.set("n", "<S-s>", "VG:s/\\w*\\. /0. /<CR><C-o>VGg<C-a>:noh<CR>")

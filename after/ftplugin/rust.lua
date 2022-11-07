vim.opt.textwidth = 99

vim.keymap.set("n", "<C-b>", ":Compile<CR>")
vim.keymap.set("n", "<Leader>x", ":Cargo run<CR>")
vim.keymap.set("n", "<S-k>", ":lua vim.lsp.buf.hover()<CR>")

vim.cmd("abb dd #[derive(Debug)]")


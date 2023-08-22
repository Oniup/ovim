-- NOTE: Spellings key sets => zg = spell check is wrong, z= list of spellings to select
local opts = { noremap = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("n", "<leader>n", ":noh<CR>", opts)

-- Don"t copy to clipboard
vim.keymap.set("n", "<leader>d", "\"_d", opts)
vim.keymap.set("n", "<leader>c", "\"_c", opts)
vim.keymap.set("x", "<leader>d", "\"_d", opts)
vim.keymap.set("x", "<leader>c", "\"_c", opts)
vim.keymap.set("x", "<leader>p", "\"_dP", opts)

-- Buffer Navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", "qq", ":bdelete<CR>", opts)

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Window Split
vim.keymap.set("n", "<leader>sj", ":split<CR>", opts)
vim.keymap.set("n", "<leader>sl", ":vsplit<CR>", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

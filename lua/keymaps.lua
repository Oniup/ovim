-- NOTE: Spellings key sets => zg = spell check is wrong, z= list of spellings to select

local opts = { noremap = true }
local keyset = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keyset("i", "jk", "<ESC>", opts)
keyset("n", "<leader>n", ":noh<CR>", opts)

-- Don"t copy to clipboard
keyset("n", "<leader>d", "\"_d", opts)
keyset("n", "<leader>c", "\"_c", opts)
keyset("x", "<leader>d", "\"_d", opts)
keyset("x", "<leader>c", "\"_c", opts)
keyset("x", "<leader>p", "\"_dP", opts)

-- Buffer Navigation
keyset("n", "<S-l>", ":bnext<CR>", opts)
keyset("n", "<S-h>", ":bprevious<CR>", opts)
keyset("n", "qq", ":bdelete<CR>", opts)

-- Window Navigation
keyset("n", "<C-h>", "<C-w>h", opts)
keyset("n", "<C-j>", "<C-w>j", opts)
keyset("n", "<C-k>", "<C-w>k", opts)
keyset("n", "<C-l>", "<C-w>l", opts)

-- Window Split
keyset("n", "<leader>sj", ":split<CR>", opts)
keyset("n", "<leader>sl", ":vsplit<CR>", opts)

-- Resize with arrows
keyset("n", "<C-Up>", ":resize -2<CR>", opts)
keyset("n", "<C-Down>", ":resize +2<CR>", opts)
keyset("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keyset("n", "<C-Right>", ":vertical resize +2<CR>", opts)

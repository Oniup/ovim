return {
  n = {
    --- Buffer Navigation
    ---------------------------------------------------------------------------
    ["<S-l>"] = { ":bnext<CR>" },
    ["<S-h>"] = { ":bprevious<CR>"},

    --- Window Navigation
    ---------------------------------------------------------------------------
    ["<C-h>"] = { "<C-w>h", "Navigate cursor to the left side window" },
    ["<C-j>"] = { "<C-w>j", "Navigate cursor to the lower window" },
    ["<C-k>"] = { "<C-w>k", "Navigate cursor to the upper window" },
    ["<C-l>"] = { "<C-w>l", "Navigate cursor to the right side window" },

    --- Resize with arrows
    -------------------------------------------------------------------------------
    ["<C-Up>"]     = { ":resize -2<CR>", "Resize window" },
    ["<C-Down>"]   = { ":resize +2<CR>", "Resize window" },
    ["<C-Left>"]   = { ":vertical resize -2<CR>", "Resize window" },
    ["<C-Right>"]  = { ":vertical resize +2<CR>", "Resize window" },
  },
}

return {
  leader = " ",
  i = {
    ["jk"] = { "<esc>", "Escape from insert mode back into normal", { noremap = true } },
  },
  n = {
    ["qq"]         = { ":bdelete<CR>", "Delete current buffer", { noremap = true } },
    ["<leader>nh"] = { ":noh<CR>", "Clear highlight from searching", { noremap = true } },
    ["<leader>lz"] = { ":Lazy<CR>", "Open plugin manager" },

    --- Window splits
    ---------------------------------------------------------------------------
    ["<leader>sj"] = { ":split<CR>", "Split window below" },
    ["<leader>sl"] = { ":vsplit<CR>", "Split window to the right" },

    --- Don"t copy to clipboard
    ---------------------------------------------------------------------------
    ["<leader>d"]  = { "\"_d", "Delete without yanking", { noremap = true } },
    ["<leader>c"]  = { "\"_c", "Delete without yanking", { noremap = true } },
  },
  x = {
    --- Don"t copy to clipboard
    ---------------------------------------------------------------------------
    ["<leader>d"] = { "\"_d", "Delete without yanking", { noremap = true } },
    ["<leader>c"] = { "\"_c", "Delete without yanking", { noremap = true } },
    ["<leader>p"] = { "\"_dP", "Paste without yanking replaced text", { noremap = true } },
  },
}

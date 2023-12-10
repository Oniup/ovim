return {
  leader = " ",
  general = {
    i = {
      ["jk"] = { "<esc>", "Escape from insert mode back into normal" },
    },
    n = {
      ["qq"]         = { ":bdelete<CR>", "Delete current buffer" },
      ["<leader>nh"] = { ":noh<CR>", "Clear highlight from searching" },
      ["<leader>lz"] = { ":Lazy<CR>", "Open plugin manager" },

      --- Window splits
      -------------------------------------------------------------------------
      ["<leader>sj"] = { ":split<CR>", "Split window below" },
      ["<leader>sl"] = { ":vsplit<CR>", "Split window to the right" },

      --- Don"t copy to clipboard
      -------------------------------------------------------------------------
      ["<leader>d"]  = { "\"_d", "Delete without yanking" },
      ["<leader>c"]  = { "\"_c", "Delete without yanking" },
    },
    x = {
      --- Don"t copy to clipboard
      -------------------------------------------------------------------------
      ["<leader>d"] = { "\"_d", "Delete without yanking" },
      ["<leader>c"] = { "\"_c", "Delete without yanking" },
      ["<leader>p"] = { "\"_dP", "Paste without yanking replaced text" },
    },
    v = {
      --- Don"t copy to clipboard
      -------------------------------------------------------------------------
      ["<leader>d"] = { "\"_d", "Delete without yanking" },
      ["<leader>c"] = { "\"_c", "Delete without yanking" },
      ["<leader>p"] = { "\"_dP", "Paste without yanking replaced text" },
    }
  }
}

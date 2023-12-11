return {
  general = {
    n = {
      ["qq"] = { ":bdelete<cr>", desc = "Delete current buffer" },
      ["<leader>nh"] = { ":noh<cr>", desc = "Clear highlight" },
      ["<leader>d"] = { ":\"_d", desc = "Delete without yanking" },
      ["<leader>c"] = { ":\"_c", desc = "Delete without yanking" },
    },
    x = {
      ["<leader>d"] = { "\"_d", desc = "Delete without yanking" },
      ["<leader>c"] = { "\"_c", desc = "Delete without yanking" },
      ["<leader>p"] = { "\"_dP", desc = "Paste without yanking replaced text" },
    }
  }
}

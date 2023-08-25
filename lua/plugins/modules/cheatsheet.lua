return {
  "sudormrfbin/cheatsheet.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>?", ":Cheatsheet<CR>", mode = "n" },
  },
  cmd = { "Cheatsheet" },
  opts = {
    bundled_cheatsheets = {
      enabled = { "default" }
    },
  },
}

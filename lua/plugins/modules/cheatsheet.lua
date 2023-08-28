return {
  "sudormrfbin/cheatsheet.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
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

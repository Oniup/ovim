local M = {}

M.plugin = {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "InsertEnter",
  config = true,
}

return M

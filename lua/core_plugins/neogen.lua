local M = {}

M.name = "neogen"

M.info = {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "InsertEnter"
}

return M

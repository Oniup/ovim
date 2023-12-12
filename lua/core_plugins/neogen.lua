local M = {}

M.opts = {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "InsertEnter",
  config = true,
}

return M

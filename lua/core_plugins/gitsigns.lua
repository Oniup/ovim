local M = {}
local icons = require("core.utils").icons

M.opts = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  opts = {
    signs = icons.gitsigns,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
    },
  }
}

return M

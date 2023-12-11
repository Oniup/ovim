local icons = require("core.utils").icons
local M = {}

name = "gitsigns"

M.info = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
}

M.opts = {
  signs = icons.gitsigns,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
  },
}

return M

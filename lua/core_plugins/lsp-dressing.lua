local M = {}
local icons = require("core.utils").icons

M.plugin = {
  "stevearc/dressing.nvim",
  event = "BufEnter",
  opts = {
    input = {
      border = icons.border,
    },
    mappings = {
      n = {
        ["qq"] = "Close",
      },
      i = {
        ["qq"] = "Close",
      },
    }
  }
}

return M

local M = {}
local ui = require("core.utils").ui

M.plugin = {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      border = ui.border.type,
    },
    mappings = {
      n = {
        ["qq"] = "Close",
      },
      i = {
        ["qq"] = "Close",
      },
    },
  },
}

return M

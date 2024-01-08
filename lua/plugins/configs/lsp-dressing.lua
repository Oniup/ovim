local M = {}

local ui = require("core.utils").ui

M.require_name = "dressing"

M.opts = {
  input = {
    border = ui.border.type,
  },
  mappings = {
    n = {
      ["q"] = "Close",
    },
  },
}

return M

local M = {}

M.opts = {
  signs = require("core.utils").icons.gitsigns,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
  },
}

return M

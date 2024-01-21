local M = {}

local ui = require("core.utils").ui

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

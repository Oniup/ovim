local M = {}

local u = require("core.utils")

M.opts = {
    shade_terminals = false,
    direction = "horizontal",
    autochdir = true,
    persist_mode = false,
    float_opts = {
        border = u.ui.border.type,
        width = 0.6,
        height = 0.6,
    },
}

return M

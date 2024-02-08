local M = {}

local border_type = require("core.utils").ui.border.type
local no_border = border_type == "solid" or border_type == "none"

M.opts = {
    style = {
        no_border = false,
    },
}

return M

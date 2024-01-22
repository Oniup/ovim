local M = {}

local u = require("core.utils")

M.opts = {
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
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

if vim.g.colors_name == "ignite" then
    M.opts.shade_terminals = true
    M.opts.highlights = {
        Normal = {
            link = "ColGroupBackground0",
        },
    }
end

return M

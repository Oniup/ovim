local M = {}

local ui = require("core.utils").ui

M.opts = {
    animation = false,
    autohide = false,
    tabpages = true,
    clickable = true,
    icons = {
        buffer_index = false,
        buffer_number = false,
        button = ui.icons.barbar.close,
        separator = ui.icons.barbar.separator,
        separator_at_end = false,
        modified = {
            button = ui.icons.barbar.modified,
        },
        filename = true,
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = {
                enabled = false,
                icon = ui.icons.diagnostics.error,
            },
            [vim.diagnostic.severity.WARN] = {
                enabled = false,
                icon = ui.icons.diagnostics.warn,
            },
            [vim.diagnostic.severity.INFO] = {
                enabled = false,
                icon = ui.icons.diagnostics.info,
            },
            [vim.diagnostic.severity.HINT] = {
                enabled = false,
                icon = ui.icons.diagnostics.int,
            },
        },
        gitsigns = {
            added = { enabled = false },
            changed = { enabled = false },
            deleted = { enabled = false },
        },
        filetype = {
            enabled = false,
        },
    },
    sidebar_filetypes = {
        NvimTree = true,
    },
    no_name_title = "[Empty]",
}

return M

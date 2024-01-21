local M = {}

local ui = require("core.utils").ui

M.opts = {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    actions = {
        file_popup = {
            open_win_config = {
                border = ui.border.type,
            },
        },
    },
    renderer = {
        root_folder_label = false,
        indent_width = 1,
        icons = {
            glyphs = ui.icons.nvim_tree_glyphs,
        },
    },
    diagnostics = {
        enable = false,
        icons = {
            error = ui.icons.diagnostics.error,
            warning = ui.icons.diagnostics.warn,
            info = ui.icons.diagnostics.info,
            hint = ui.icons.diagnostics.hint,
        },
    },
}

return M

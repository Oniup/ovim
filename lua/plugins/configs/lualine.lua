local M = {}

local ui = require("core.utils").ui

M.statusline_mode = 2
M.cmdline_height = 1

M.sections = {
    mode = {
        "mode",
        fmt = function(output)
            return ui.icons.lualine_icon .. " " .. string.sub(output, 1, 1)
        end,
    },
    diff = {
        "diff",
        colored = true,
        symbols = {
            added = ui.icons.nvim_tree_glyphs.git.untracked .. " ",
            modified = ui.icons.nvim_tree_glyphs.git.renamed .. " ",
            removed = ui.icons.nvim_tree_glyphs.git.deleted .. " ",
        },
    },
    branch = "branch",
    location = {
        "location",
        fmt = function(output)
            if output then
                local pos = vim.api.nvim_win_get_cursor(0)
                local line_count = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf())
                output = pos[2] .. ":" .. pos[1] .. "/" .. line_count
            end
            return output
        end,
    },
    lsp_progress = {
        require("lsp-progress").progress,
    },
    progress = "progress",
    filename = {
        "filename",
        fmt = function(output)
            return string.match(output, "^(.*)%." .. vim.bo.filetype .. "$")
        end,
        file_status = false,
        newfile_status = false,
        path = 0,
        symbols = {
            modified = "",
            readonly = "",
            unnamed = "",
            newfile = "",
        },
    },
    filetype = {
        "filetype",
        colored = true,
        icon_only = true,
    },
    filetype_no_color = {
        "filetype",
        colored = false,
        icon_only = true,
    },
    diagnostics = {
        "diagnostics",
        diagnostics_color = {
            diagnostics_color = {
                error = "DiagnosticError",
                warn = "DiagnosticWarn",
                info = "DiagnosticInfo",
                hint = "DiagnosticHint",
            },
            colored = true,
            update_in_insert = true,
            always_visable = true,
        },
        symbols = {
            error = ui.icons.diagnostics.error,
            warn = ui.icons.diagnostics.warn,
            info = ui.icons.diagnostics.info,
            hint = ui.icons.diagnostics.hint,
        },
    },
    searchcount = {
        "searchcount",
        maxcount = 999,
        timeout = 500,
    },
}

M.opts = {
    options = {
        theme = require("ignite.lualine_theme"),
        component_separators = { right = "", left = "" },
        section_separators = { right = "", left = "" },
    },
    sections = {
        lualine_a = { M.sections.mode },
        lualine_b = { M.sections.branch },
        lualine_c = { M.sections.diff },
        lualine_x = { M.sections.diagnostics, M.sections.lsp_progress },
        lualine_y = { M.sections.filetype, M.sections.filename },
        lualine_z = { M.sections.location },
    },
    inactive_sections = {
        lualine_c = { M.sections.diff },
        lualine_x = { M.sections.diagnostics },
        lualine_y = {
            M.sections.filetype_no_color,
            M.sections.filename,
            M.sections.location,
        },
    },
    extensions = {
        "lazy",
        "mason",
        "nvim-dap-ui",
        "nvim-tree",
        "quickfix",
        "toggleterm",
    },
}

function M.loaded_callback(config)
    vim.opt.laststatus = config.statusline_mode
    vim.opt.cmdheight = config.cmdline_height
    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
    })
end

return M

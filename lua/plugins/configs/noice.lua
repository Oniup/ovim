local M = {}

local u = require("core.utils")
local icons = u.ui.icons.noice

M.opts = {
    cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {},
        format = {
            cmdline = { pattern = "^:", icon = icons.cmdline.cmdline, lang = "vim" },
            search_down = {
                title = "Search",
                kind = nil,
                pattern = "^/",
                icon = icons.cmdline.search,
                lang = "regex",
            },
            search_replace = {
                title = "Find and Replace",
                pattern = { "^:%%s/", "^:%%s%!", "^:%%s%*" },
                icon = icons.cmdline.filter,
                confirm = true,
                lang = "regex",
            },
            lua = {
                pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                icon = icons.cmdline.lua,
                lang = "lua",
            },
            python = {
                pattern = { "^:%s*python%s+", "^:%s*python%s*=%s*", "^:%s*=%s*" },
                icon = icons.cmdline.python,
                lang = "python",
            },
            help = { pattern = "^:%s*he?l?p?%s+", icon = icons.cmdline.help },
        },
    },
    messages = { enabled = true },
    popupmenu = { enabled = true },
    lsp = {
        progress = { enabled = false },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true },
        signature = { enabled = true },
        message = { enabled = true },
    },
    presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
    },
    views = {
        cmdline_popup = {
            border = {
                style = u.ui.border.stype,
            },
        },
    },
}

return M

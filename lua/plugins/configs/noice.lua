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
                kind = "search",
                pattern = "^/",
                icon = icons.cmdline.search,
                lang = "regex",
            },
            search_up = {
                kind = "search",
                pattern = "^%?",
                icon = icons.cmdline.search,
                lang = "regex",
            },
            filter = {
                pattern = { "^:%%s/", "^:%%s%!", "^:%%s%*" },
                icon = icons.cmdline.search,
                lang = "regex",
            },
            lua = {
                pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                icon = icons.cmdline.lua,
                lang = "lua",
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

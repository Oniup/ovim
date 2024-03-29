local M = {}

M.lualine_icon = "󰈸"

M.mason = {
    package_installed = "",
    package_pending = "",
    package_uninstalled = "",
}

M.progress = {
    spinner = { "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" },
    done = "",
}

M.barbar = {
    separator = { left = "▎", right = "" },
    close = "",
    modified = "",
    present = "default", -- default', 'powerline', or 'slanted'
}

M.dap = {
    DapBreakpoint = { text = "", texthl = "DiagnosticSignError" },
    DapBreakpointCondition = { text = "", texthl = "DiagnosticSignError" },
    DapLogPoint = { text = "󰹕", texthl = "DiagnosticSignInfo" },
    DapStopped = { text = "➜", texthl = "Operator" },
    DapBreakpointRejected = { text = "", texthl = "Comment" },
}

M.dapui = {
    debugging_controls = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
    },
    expanding_controls = {
        collapsed = "",
        current_frame = "",
        expanded = "",
    },
}

M.lazy = {
    cmd = "",
    config = "",
    event = "",
    ft = "󰈙",
    init = "",
    import = "",
    keys = "󰌌",
    lazy = "󰂠",
    loaded = "",
    not_loaded = "",
    plugin = "",
    runtime = "",
    require = "󰢱",
    source = "󰅱",
    start = "",
    task = "",
    list = { "●", "➜", "★", "‒" },
}

M.diagnostics = {
    error = " ",
    warn = " ",
    info = " ",
    hint = " ",
    other = {
        todo = " ",
        warn = "󰀪 ",
        hack = " ",
        note = "󱞂 ",
        perf = "󱫍 ",
        test = " ",
    },
}

M.noice = {
    cmdline = {
        cmdline = "",
        filter = "󰈲",
        search = "",
        lua = "",
        python = "󰌠",
        help = "?",
    },
    popup = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
    },
}

M.gitsigns = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "│" },
    untracked = { text = "│" },
}

M.nvim_tree_glyphs = {
    default = "󰈙",
    symlink = "",
    bookmark = "",
    folder = { -- nf-md-folder
        arrow_closed = "",
        arrow_open = "",
        default = "󰉋",
        open = "󰝰",
        empty = "󰉖",
        empty_open = "󰷏",
        symlink = "󰉕",
        symlink_open = "󰉕",
    },
    git = {
        unstaged = "",
        staged = "»",
        unmerged = "󰘭",
        renamed = "",
        untracked = "",
        deleted = "󰧧",
        ignored = "",
    },
}

M.whichkey = {
    breadcrumb = "»",
    separator = "➜ ",
    group = "",
}

M.kind = {
    Text = "󱌯",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "󰯠",
    Unit = "",
    Value = "",
    Enum = "",
    EnumMember = "",
    Keyword = "",
    Snippet = "",
    Color = "♥",
    File = "󰧮",
    Reference = "",
    Folder = "󰉖",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
    Parameter = "󰘦",
    Unknown = "?",
    Number = "",
    Boolean = "󰨚",
    Character = "󱌯",
    String = "",
    Codeium = "󱙺",
    Copilot = "",
}

return M

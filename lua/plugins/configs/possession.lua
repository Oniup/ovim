local M = {}

M.opts = {
    silent = true,
    load_silent = true,
    logfile = true,
    commands = {
        save = "SeSave",
        load = "SeLoad",
        rename = "SeRename",
        close = "SeClose",
        delete = "SeDelete",
        show = "SeShow",
        list = "SeList",
    },
    plugins = {
        dap = true,
        dapui = true,
        nvim_tree = false,
        symbols_outline = false,
        delete_buffers = false,
        delete_hidden_buffers = {
            hooks = {
                "before_load",
                vim.o.sessionoptions:match("buffer") and "before_save",
            },
            force = true,
        },
    },
    autosave = {
        current = true,
        on_quit = true,
        on_load = true,
        tmp = false,
    },
    telescope = {
        previewer = {
            enabled = false,
        },
        list = {
            default_action = "load",
            mappings = {
                save = { n = "x", i = "<c-x>" },
                load = { n = "l", i = "<c-v>" },
                delete = { n = "<Del>", i = "<c-t>" },
                rename = { n = "r", i = "<c-r>" },
            },
        },
    },
}

function M.loaded_callback()
    local telescope = require("telescope")
    telescope.load_extension("possession")
end

return M

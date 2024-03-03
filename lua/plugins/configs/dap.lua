local M = {}
local mason_dap = require("mason-nvim-dap")

local function default_mason_dap_handle(dapconfig)
    mason_dap.default_setup(dapconfig)
end

M.opts = {
    mason_dap = {
        handlers = {
            default_mason_dap_handle,
        },
    },
    adapters = {},
    configurations = {},
}

function M.loaded_callback(config)
    local dap = require("dap")
    dap.set_log_level("ERROR")

    local icons = require("core.utils").ui.icons.dap
    for k, v in pairs(icons) do
        vim.fn.sign_define(k, v)
    end
    mason_dap.setup(config.opts.mason_dap)

    for k, v in pairs(config.opts.adapters) do
        dap.adapters[k] = v
    end
    for k, v in pairs(config.opts.configurations) do
        dap.configurations[k] = v
    end
end

return M

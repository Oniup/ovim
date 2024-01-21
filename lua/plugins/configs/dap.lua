local M = {}

function M.loaded_callback()
    local icons = require("core.utils").ui.icons.dap
    for k, v in pairs(icons) do
        vim.fn.sign_define(k, v)
    end

    local mason_dap = require("mason-nvim-dap")
    mason_dap.setup({
        handlers = {
            function(dapconfig)
                mason_dap.default_setup(dapconfig)
            end,
        },
    })
end

return M

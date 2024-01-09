local M = {}

local mason_dap = require("mason-nvim-dap")

function M.setup_handlers(config)
  mason_dap.default_setup(config)
end

function M.loaded_callback(_)
  mason_dap.setup({
    handlers = {
      M.setup_handlers,
    },
  })
end

return M

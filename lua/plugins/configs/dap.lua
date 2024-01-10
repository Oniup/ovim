local M = {}

function M.loaded_callback()
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

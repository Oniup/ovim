local usr_colorscheme = require("core.utils").prequire("config.colorscheme")
local M = {}

M.name = "ignite"

M.info = {
  "Oniup/ignite.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local name = M.name
    if usr_colorscheme then
      name = usr_colorscheme.name
      if usr_colorscheme.setup then
        usr_colorscheme.setup()
      end
    else
      require("ignite").setup()
    end

    vim.cmd.colorscheme(name)
  end
}

return M

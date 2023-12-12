local M = {}

M.opts = {
  "Oniup/ignite.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- TODO: Allow to change colorscheme
    require("ignite").setup()
    vim.cmd.colorscheme("ignite")
  end
}

return M

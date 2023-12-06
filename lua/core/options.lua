local M = {}

M.get_all_set_options = function()
  local opts = require("defaults.options")
  local usr_opts_ok, usr_opts = pcall(require, "config.options")
  if usr_opts_ok then
    opts = vim.tbl_deep_extend("force", opts, usr_opts)
  end
  return opts
end

M.load_opts = function()
  local opts = M.get_all_set_options()
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

return M

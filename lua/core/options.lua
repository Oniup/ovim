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
  for k, v in pairs(opts.vim_opts) do
    vim.opt[k] = v
  end

  vim.g.mapleader = opts.leader_key
  vim.g.maplocalleader = opts.leader_key
end

M.get_plug_opts = function(plugin_name)
  local default_result = require("core.utils").prequire("defaults.plugin_options." .. plugin_name)
  local usr_result = require("core.utils").prequire("config.plugin_options." .. plugin_name)
  local opts = nil

  if default_result then
    opts = default_result
  end

  if usr_result then
    if not opts then
      opts = usr_result
    else
      opts = vim.tbl_deep_extend("force", opts, usr_result)
    end
  end

  if not opts then
    opts = {}
  end

  return opts
end

return M

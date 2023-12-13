local M = {}

M.get_plugin_configs = function()
  local utils = require("core.utils")
  local module_paths = utils.get_all_modules_within("core_plugins")

  local configs = {}
  for _, module in ipairs(module_paths) do
    local config = utils.prequire(module.mod)

    if config then
      if config.before_loading then
        config.before_loading()
      end

      table.insert(configs, config.opts)
    end
  end

  return configs
end

M.load_plugins = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup(M.get_plugin_configs(), {
    defaults = {
      lazy = true,
    },
    install = {
      missing = true,
    },
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
    ui = {
      border = "single",
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "zipPlugin",
        },
      },
    },
  })
end

M.plugin_config = function(plugin_name)
  local opts = require("core.options").get_plug_opts(plugin_name)
end

return M

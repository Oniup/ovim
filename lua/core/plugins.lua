local M = {}
local utils = require("core.utils")

M.get_plugin_configs = function()
  local modules_paths = utils.get_all_modules_within({ "core_plugins", "config.plugins" })

  -- Load modules
  local configs = {}
  for _, modules in pairs(modules_paths) do
    local config = utils.prequire_extend(modules)

    if config then
      if config.before_loading then
        config.before_loading()
      end

      table.insert(configs, config.plugin)
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
      version = "*",
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
      border = utils.icons.border,
      size = { width = 0.6, height = 0.6 },
      icons = utils.icons.lazy,
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

return M

local M = {}
local utils = require("core.utils")
local keymaps = require("core.keymaps")

M.get_plugin_configs = function()
  local modules_paths =
    utils.get_all_modules_within({ "core_plugins", "config.plugins" })

  -- Load modules
  local configs = {}
  for name, modules in pairs(modules_paths) do
    local config = utils.prequire_extend(modules)

    if config and config.plugin then
      config.plugin.keys = keymaps.set_plugin_keymap(name)

      if not config.plugin.init then
      end

      if config.before_loading then
        config.before_loading()
      end

      table.insert(configs, config.plugin)
    else
      vim.notify(
        "plugin config for "
          .. vim.inspect(name)
          .. " requires a M.plugin table for lazy.nvim to interpret."
      )
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
    ui = {
      border = utils.icons.border,
      size = { width = 0.6, height = 0.6 },
      icons = utils.icons.lazy,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "2html_plugin",
          "tohtml",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
          "tutor",
          "rplugin",
          "syntax",
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        },
      },
    },
  })
end

return M

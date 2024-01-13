local M = {}

local u = require("core.utils")

function M.plugin_setup_config()
  local plugins = require("plugins")
  local usr_plugins = u.prequire("custom.plugins")
  if usr_plugins then
    for _, plug in ipairs(usr_plugins) do
      table.insert(plugins, plug)
    end
  end
  -- Construct lazy init and config functions
  for i, plug in ipairs(plugins) do
    local plug_opts = u.map_tbl({
      enabled = true,
      enable_config = true,
      enable_setup = true,
      lazy_on_file_open = false,
    }, plug.opts)
    plug.opts = nil
    if not plug_opts.enabled then
      table.remove(plugins, i)
    end
    -- Create init function for loading mappings and custom lazy loading logic
    plug.init = function(lazy_plugin)
      if plug_opts.lazy_on_file_open then
        M.lazy_load_plugin_on_file_open(lazy_plugin.name)
      end
      u.set_mappings(u.stripped_plugin_name(lazy_plugin.name))
    end
    -- Create config function
    if plug_opts.enable_config then
      plug.config = function(lazy_plugin, _)
        local plug_name = u.stripped_plugin_name(lazy_plugin.name)
        local plug_settings = u.get_mapped_plugin_config(plug_name)
        local call_setup_name = plug_name
        if plug_opts.setup_module_name then
          call_setup_name = plug_opts.setup_module_name
        end
        if plug_opts.enable_setup then
          require(call_setup_name).setup(plug_settings.opts)
        end
        if plug_settings and plug_settings.loaded_callback then
          plug_settings.loaded_callback(plug_settings)
        end
      end
    end
  end
  return plugins
end

function M.load_lazy_plugins(opts)
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
  require("lazy").setup(M.plugin_setup_config(), opts)
end

--- Modified variant of https://github.com/NvChad/NvChad/blob/v2.0/lua/core/utils.lua
function M.lazy_load_plugin_on_file_open(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("LazyLoadOnFileOpen_" .. plugin, {}),
    callback = function()
      local this = vim.fn.expand("%")
      local not_allowed = { "NvimTree_1", "[lazy]", "[mason]", "" }
      for _, ft in ipairs(not_allowed) do
        if this == ft then
          return
        end
      end
      vim.api.nvim_del_augroup_by_name("LazyLoadOnFileOpen_" .. plugin)
      require("lazy").load({ plugins = plugin })
    end,
  })
end

return M

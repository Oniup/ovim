local M = {}

local u = require("core.utils")

function M.plugin_setup_config()
  local plugins = require("plugins")
  table.insert(plugins, { import = "custom.plugins" })

  -- Construct lazy init and config functions
  for i, plug in ipairs(plugins) do
    -- Construction options (default lazy opts are used for this)
    local loading_opts = u.map_opts({
      enable_config = true,
      enable_plugin = true,
    }, plug.opts)

    if not loading_opts.enable_plugin then
      table.remove(plugins, i)
    end

    -- Create init function for loading mappings and custom lazy loading logic
    plug.init = function(lazy_plugin)
      if not loading_opts.lazy_on_file_open then
        loading_opts.lazy_on_file_open = not lazy_plugin._.cache
      end

      local name = lazy_plugin.name
      if loading_opts.lazy_on_file_open and lazy_plugin.lazy then
        M.lazy_load_plugin_on_file_open(name)
      end

      u.set_mappings(u.stripped_plugin_name(name))
    end

    -- Create config function if it doesn't already exist
    if not plug.config and loading_opts.enable_config then
      plug.config = function(lazy_plugin, _)
        local plug_name = u.stripped_plugin_name(lazy_plugin.name)
        local plug_settings = u.get_mapped_plugin_config(plug_name)

        local call_setup_name = plug_name
        if loading_opts.setup_module then
          call_setup_name = loading_opts.setup_module
        end

        if not vim.tbl_isempty(plug_settings) then
          -- Call custom config function if it exists
          if
            plug_settings.setup ~= nil
            and type(plug_settings.setup) == "function"
          then
            plug_settings.setup(lazy_plugin, plug_settings.opts)

          -- Auto call plugin setup function and pass options from config module
          elseif plug_settings.setup == true or plug_settings.setup == nil then
            require(call_setup_name).setup(plug_settings.opts)
          end
        else
          require(call_setup_name).setup(plug_settings.opts)
        end

        u.load_ui_module(plug_name)

        if plug_settings and plug_settings.setup_callback then
          plug_settings.setup_callback(plug_settings)
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
      local ft = vim.fn.expand("%")
      local ft_allowed = ft ~= "NvimTree_1" and ft ~= "[lazy]" and ft ~= ""

      if ft_allowed then
        vim.api.nvim_del_augroup_by_name("LazyLoadOnFileOpen_" .. plugin)

        if plugin ~= "treesitter" then
          vim.schedule(function()
            require("lazy").load({ plugins = plugin })

            if plugin == "lspconfig" then
              vim.cmd("silent! do FileType")
            end
          end, 0)
        else
          require("lazy").load({ plugins = plugin })
        end
      end
    end,
  })
end

return M

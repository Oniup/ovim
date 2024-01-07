local M = {}

local u = require("core.utils")

function M.plugin_setup_config()
  local plugins = u.map_opts(require("plugins"), u.prequire("config.plugins"))

  for _, plug in ipairs(plugins) do
    if not plug.config then
      plug.config = function(lazy_plugin, opts)
        local plug_call_name = u.stripped_plugin_name(lazy_plugin.name)
        local config = u.get_mapped_plugin_config(plug_call_name)

        if config then
          if not opts then
            opts = config.opts or {}
          else
            opts = u.map_opts(opts, config.opts)
          end

          if config.setup ~= nil and type(config.setup) == "function" then
            config.setup(lazy_plugin, opts)
          elseif config.setup == true or config.setup == nil then
            if config.require_name then
              plug_call_name = config.require_name
            end

            require(plug_call_name).setup(opts)
          end
        else
          require(plug_call_name).setup(opts)
        end

        if config and config.setup_callback then
          config.setup_callback(config)
        end
      end
    end

    plug.init = function(lazy_plugin)
      local name = lazy_plugin.name
      local opts = {
        lazy_load_plugin_on_file_open = not lazy_plugin._.cache,
      }

      -- Remove init only options, should not be passed to config
      if lazy_plugin.opts then
        for k, _ in pairs(opts) do
          if lazy_plugin.opts[k] then
            opts[k] = lazy_plugin.opts[k]
            lazy_plugin.opts[k] = nil
          end
        end
      end

      if opts.lazy_load_plugin_on_file_open then
        if lazy_plugin.lazy then
          M.lazy_load_plugin_on_file_open(name)
        end
      end

      u.set_mappings(u.stripped_plugin_name(name))
    end
  end

  return plugins
end

function M.load_lazy_plugins()
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

  require("lazy").setup(M.plugin_setup_config(), {
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
      border = u.ui.border.type,
      size = { width = 0.6, height = 0.6 },
      icons = u.ui.icons.lazy,
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

--- Modified variant of https://github.com/NvChad/NvChad/blob/v2.0/lua/core/utils.lua
function M.lazy_load_plugin_on_file_open(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("LazyLoadOnFileOpen_" .. plugin, {}),
    callback = function()
      local current_file = vim.fn.expand("%")
      local load_plugin = current_file ~= "NvimTree_1"
        and current_file ~= "[lazy]"
        and current_file ~= ""

      if load_plugin then
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

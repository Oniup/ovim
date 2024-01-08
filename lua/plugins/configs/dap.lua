local M = {}
local utils = require("core.utils")

function M.load_dap_config(module, dapconfig)
  local function passed(condition, err_msg)
    if condition then
      return true
    end

    vim.notify(
      "Failed to load dapconfig "
        .. vim.inspect(err_msg)
        .. "\nmodule = "
        .. vim.inspect(module)
        .. "\ndapconfig = "
        .. vim.inspect(dapconfig),
      vim.log.levels.ERROR
    )
    return false
  end

  local passed_checks = passed(dapconfig, "dapconfig is null")
    and passed(dapconfig.adapters, "adapters is null")
    and passed(dapconfig.configurations, "configurations is null")
    and passed(type(dapconfig.adapters) == "table")
    and passed(type(dapconfig.configurations) == "table")

  if not passed_checks then
    return false
  end

  local dap = require("dap")
  for type, conf in pairs(dapconfig) do
    dap[type] = conf
  end

  return true
end

function M.load_all_dapconfigs(modules_paths)
  local module_names = utils.get_all_modules_at(modules_paths)

  for _, modules in pairs(module_names) do
    local dapconfig = utils.prequire_extend(modules)

    if dapconfig and type(dapconfig) == "table" then
      M.load_dap_config(modules, dapconfig)
    end
  end
end

M.plugin = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope-dap.nvim",
    "rcarriga/cmp-dap",
  },
  lazy = true,
  opts = {
    dapui = {
      layouts = {
        {
          size = 40,
          position = "left",
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
        },
        {
          size = 10,
          position = "bottom",
          elements = {
            { id = "repl", size = 0.18 },
            { id = "console", size = 1.0 },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local dap = require("dap")

    require("dapui").setup(opts.dapui)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end

    local telescope = require("telescope")
    telescope.load_extension("dap")

    M.load_all_dapconfigs({ "plugins.dapconfigs", "custom.plugins.dapconfigs" })

    require("cmp").setup.filetype(
      { "dap-repl", "dapui_watches", "dapui_hover" },
      {
        sources = {
          { name = "dap" },
        },
      }
    )
  end,
}

return M

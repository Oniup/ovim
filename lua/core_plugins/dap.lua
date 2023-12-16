local M = {}
local utils = require("core.utils")

function M.load_dap_config(module, dapconfig)
  local function passed(condition, err_msg)
    if condition then
      return true
    end

    vim.notify(
      "Failed to load dapconfig " .. vim.inspect(err_msg) .. "\nmodule = " ..
      vim.inspect(module) .. "\ndapconfig = " .. vim.inspect(dapconfig),
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
  local module_names = utils.get_all_modules_within(modules_paths)

  for _, modules in pairs(module_names) do
    local dapconfig = utils.prequire_extend(modules)

    if dapconfig and type(dapconfig) == "table" then
      M.load_dap_config(modules, dapconfig)
    end
  end
end

function M.print_dap_lang_configurations()
  local dap = require("dap")
  vim.notify("DAP adapters = " .. vim.inspect(dap.adapters) ..
    "\nDAP configurations = " .. vim.inspect(dap.configurations),
    vim.log.levels.INFO)
end

M.plugin = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope-dap.nvim",
  },
  lazy = true,
  opts = {
    dapui = {}
  },
  config = function(_, opts)
    local dap = require("dap")

    require("dapui").setup(opts.dapui)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end

    local telescope = require("telescope")
    telescope.load_extension("dap")

    M.load_all_dapconfigs({ "defaults.dapconfigs", "config.dapconfigs" })
  end,
}

return M

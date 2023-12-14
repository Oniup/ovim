local M = {}

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
  event = "BufEnter",
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

    local modules = require("core.utils").get_all_modules_within("defaults.dapconfigs")
    for _, module in ipairs(modules) do
      local dapconfig = require(module.mod)

      if dapconfig and type(dapconfig) == "table" then
        M.load_dap_config(module, dapconfig)
      end
    end
  end,
}

return M

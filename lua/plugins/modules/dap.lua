return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope-dap.nvim",
  },
  keys = {
    { "<F5>",       mode = "n" },
    { "<leader>dc", mode = "n" },
    { "<leader>bb", mode = "n" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    local telescope = require("telescope")
    telescope.load_extension("dap")

    local opts = { silent = true }
    vim.keymap.set("n", "<F5>", dap.continue, opts)
    vim.keymap.set("n", "<F10>", dap.step_over, opts)
    vim.keymap.set("n", "<F11>", dap.step_into, opts)
    vim.keymap.set("n", "<F12>", dap.step_out, opts)
    vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, opts)
    vim.keymap.set("n", "<leader>bc", dap.clear_breakpoints, opts)
    vim.keymap.set("n", "<leader>bt", dapui.close, opts)

    vim.keymap.set("n", "<leader>bl", telescope.extensions.dap.list_breakpoints, opts)
    vim.keymap.set("n", "<leader>dc", telescope.extensions.dap.configurations, opts)
    vim.keymap.set("n", "<leader>dm", telescope.extensions.dap.commands, opts)

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close()

    -- Loading DAP configurations
    local path = vim.fn.stdpath("config") .. "/lua/plugins/dap_lang_conf"
    local program
    if vim.fn.has("win32") then
      path = path:gsub("/", "\\")
      program = "dir \"" .. path .. "\" /b"
    else
      program = "ls -pa " .. path .. " | grep -v"
    end
    for mod in io.popen(program):lines() do
      local modname = string.sub(mod, 1, string.len(mod) - 4) -- 4 -> .lua
      local status, module = pcall(require, "plugins.dap_lang_conf." .. modname)
      if status then
        for k, v in pairs(module.adapters) do
          dap.adapters[k] = v
        end
        for k, v in pairs(module.configurations) do
          dap.configurations[k] = v
        end
      else
        vim.notify("Failed to load " .. mod .. " dap module", vim.log.levels.ERROR)
      end
    end
  end,
}

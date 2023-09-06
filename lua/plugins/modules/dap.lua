return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  prioroty = 998,
  lazy = false,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    vim.keymap.set("n", "<F5>", function() dap.continue() end)
    vim.keymap.set("n", "<F10>", function() dap.step_over() end)
    vim.keymap.set("n", "<F11>", function() dap.step_into() end)
    vim.keymap.set("n", "<F12>", function() dap.step_out() end)
    vim.keymap.set("n", "<Leader>bb", function() dap.toggle_breakpoint() end)
    vim.keymap.set("n", "<Leader>bc", function() dap.clear_breakpoints() end)
    vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end)
    vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end)

    local widgets = require("dap.ui.widgets")
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      widgets.hover()
    end)
    vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
      widgets.preview()
    end)
    vim.keymap.set("n", "<Leader>df", function()
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set("n", "<Leader>ds", function()
      widgets.centered_float(widgets.scopes)
    end)

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

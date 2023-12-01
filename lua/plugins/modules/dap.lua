--- @param language_name string Name is inserted into the launch configuration names for identifying the correct debugger to use
--- @param adapter string Name of the adapter CASE-SENSITIVE
--- @param extended_config table|nil Replace existing entries with new values and/or extend the default DAP configuration tab within the function
local dap_language_config = function(language_name, adapter, extended_config)
  local config = {
    name = "Launch => " .. adapter .. " (" .. language_name .. ")",
    type = adapter,
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
  }

  if extended_config ~= nil then
    config = vim.tbl_extend("force", config, extended_config)
  end

  return config
end

--- @param path string This string is appended onto the nvim-data path ```:lua print(vim.fn.stdpath("data"))```
local os_correct_nvim_data_path = function(path)
  local path = vim.fn.stdpath("data") .. path
  if vim.fn.has("win32") then
    path = string.gsub(path, "/", "\\") .. ".exe"
  end
  return path
end

--- @param unix_begin string Beginning of the UNIX path
--- @param windows_begin string Beginning of the Windows path
--- @param library_path string Rest of the string appended onto the platform specific path
local os_correct_path = function(unix_begin, windows_begin, library_path)
  local final_path = ""
  if vim.fn.has("win32") then
    final_path = windows_begin .. library_path .. ".exe"
    final_path = string.gsub(final_path, "/", "\\")
  else
    final_path = unix_begin .. library_path
  end
  return final_path
end

--- DAP Configuration
-------------------------------------------------------------------------------
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
    local dapui = require("dapui")
    local dap = require("dap")

    dapui.setup()

    --- UI events
    ---------------------------------------------------------------------------
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    --- Telescope extension
    ---------------------------------------------------------------------------
    local telescope = require("telescope")
    telescope.load_extension("dap")

    --- Keybindings
    ---------------------------------------------------------------------------
    local opts = { silent = true }

    -- Runtime
    vim.keymap.set("n", "<F5>", dap.continue, opts)
    vim.keymap.set("n", "<F10>", dap.step_over, opts)
    vim.keymap.set("n", "<F11>", dap.step_into, opts)
    vim.keymap.set("n", "<F12>", dap.step_out, opts)
    vim.keymap.set("n", "<leader>dl", telescope.extensions.dap.variables, opts)

    vim.keymap.set("n", "<leader>dt", function()
      dap.terminate()
      dapui.close()
    end, opts)

    -- Breakpoints
    vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, opts)
    vim.keymap.set("n", "<leader>bc", dap.clear_breakpoints, opts)
    vim.keymap.set("n", "<leader>bl", telescope.extensions.dap.list_breakpoints, opts)

    -- Meniscus
    vim.keymap.set("n", "<leader>dc", telescope.extensions.dap.configurations, opts)
    vim.keymap.set("n", "<leader>dm", telescope.extensions.dap.commands, opts)

    --- Configurations
    ---------------------------------------------------------------------------
    dap.adapters = {
      cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = os_correct_path("home/cpptools", "C:/cpptools",
          "/extension/debugAdapters/bin/OpenDebugAD7"),
        options = {
          detached = false
        },
        setupCommands = {
          {
            text = '-enable-pretty-printing',
            description = 'enable pretty printing',
            ignoreFailures = false
          }
        }
      },
      codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = os_correct_nvim_data_path("/mason/packages/codelldb/extension/adapter/codelldb"),
          args = {
            "--port", "${port}"
          },
          detached = false
        }
      }
    }

    dap.configurations = {
      cpp = {
        dap_language_config("C++", "cppdbg"),
        dap_language_config("C++", "codelldb", {
          stopAtEntry = true,
          terminal = "integrated",
        })
      },
      c = {
        dap_language_config("C", "cppdbg")
      },
      cs = {},
      rust = {},
      lua = {},
      python = {}
    }
  end

}

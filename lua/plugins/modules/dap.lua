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
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    --- Telescope extension
    ---------------------------------------------------------------------------
    local telescope = require("telescope")
    telescope.load_extension("dap")

    --- Keybindings
    ---------------------------------------------------------------------------
    local opts = { noremap = true, silent = true }

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
    local os_correct_path = function(unix_begin, windows_begin, library)
      local final_path = ""
      if vim.fn.has("win32") then
        final_path = windows_begin .. library .. ".exe"
        final_path = string.gsub(final_path, "/", "\\")
      else
        final_path = unix_begin .. library
      end
      return final_path
    end

    local cppdbg_configurations = function(language)
      local config = {
        name = "Launch (" .. language .. ")",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
      }
      return config
    end

    dap.adapters = {
      cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = os_correct_path("home/cpptools/", "C:/cpptools/", "extension/debugAdapters/bin/OpenDebugAD7"),
        options = {
          detached = false
        }
      }
    }
    dap.configurations = {
      cpp = {
        cppdbg_configurations("C++")
      },
      c = {
        cppdbg_configurations("C")
      },
      rust = {
        cppdbg_configurations("Rust")
      },
    }
  end
}

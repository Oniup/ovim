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
    local utils = require("utils")

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
    vim.keymap.set("n", "<leader>bl",
      telescope.extensions.dap.list_breakpoints, opts)

    -- Meniscus
    vim.keymap.set("n", "<leader>dc", telescope.extensions.dap.configurations,
      opts)
    vim.keymap.set("n", "<leader>dm", telescope.extensions.dap.commands, opts)

    --- Configurations
    ---------------------------------------------------------------------------
    dap.adapters = {
      cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = utils.os_correct_path("home/cpptools", "C:/cpptools",
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
          command = utils.os_correct_nvim_data_path(
            "/mason/packages/codelldb/extension/adapter/codelldb"),
          args = {
            "--port", "${port}"
          },
          detached = false
        }
      }
    }

    dap.configurations = {
      cpp = {
        utils.create_dap_lang_config("C++", "cppdbg"),
        utils.create_dap_lang_config("C++", "codelldb", {
          stopAtEntry = true,
          terminal = "integrated",
        })
      },
      c = {
        utils.create_dap_lang_config("C", "cppdbg"),
        utils.create_dap_lang_config("C", "codelldb", {
          stopAtEntry = true,
          terminal = "integrated",
        })
      },
      cs = {},
      rust = {},
      lua = {},
      python = {}
    }
  end

}

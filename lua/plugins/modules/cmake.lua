return {
  "Civitasv/cmake-tools.nvim",
  ft = { "cpp", "c", "h", "hpp", "cc", "ini" },
  config = function()
    local cmake_kits_path = vim.env.HOME .. "/Dev/CMakeKits.json"
    if vim.fn.has("win32") then
      cmake_kits_path = string.gsub(cmake_kits_path, "/", "\\")
    end

    local cmake_tools = require("cmake-tools")
    cmake_tools.setup({
      cmake_kits_path = cmake_kits_path
    })

    --- Override DAP key mappings
    local dap = require("dap")
    local opts = { noremap = true, silent = true }
    local dap_overrided_program_path = false
    vim.keymap.set("n", "<F5>", function()
      -- Setting the debugger directory while still allowing selecting adapter
      if not dap_overrided_program_path then
        local current_session = require("cmake-tools.session").load()
        dap_overrided_program_path = true

        local executable_path = current_session.cwd ..
            "/" .. current_session.build_directory .. "/" .. current_session.build_target
        if vim.fn.has("win32") then
          executable_path = string.gsub(executable_path, "/", "\\")
        end

        for i = 1, #dap.configurations.cpp do
          dap.configurations.cpp[i].program = executable_path
        end
        for i = 1, #dap.configurations.c do
          dap.configurations.cpp[i].program = executable_path
        end
      end
      dap.continue()
    end, opts)
  end
}

-- return {}

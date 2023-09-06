local path = "unix path ..." -- TODO: figure out unix path
if vim.fn.has("win32") then
  path = "C:\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe"
end

local M = {}

M.adapters = {
  cppdbg = {
    id = "cppdbg",
    type = "executable",
    -- command = "C:\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe",
    command = path,
    options = {
      detached = false
    }
  }
}

M.configurations = {
  cpp = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
      end,
      cwd = "${workspaceFolder}",
      stopAtEntry = false,
    },
  },
}

M.configurations.c = M.configurations.cpp

return M

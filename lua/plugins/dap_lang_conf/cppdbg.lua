local path = "unix path ..." -- TODO: figure out unix path
if vim.fn.has("win32") then
  path = "C:\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe"
end

local M = {}

M.adapters = {
  cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = path,
    options = {
      detached = false
    }
  }
}

M.configurations = {
  cpp = {
    {
      name = "launch (C++) - cpptools, OpenDebugAD7",
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
M.configurations.c[1].name = "launch (C) - cpptools, OpenDebugAD7"

return M

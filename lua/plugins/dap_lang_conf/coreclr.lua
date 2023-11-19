local path = vim.fn.stdpath("data")
    .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg"
if vim.fn.has("win32") then
  path = path:gsub("/", "\\\\")
  path = path .. ".exe"
end

local M = {}

M.adapters = {
  coreclr = {
    type = "executable",
    command = path,
    args = { "--interpreter=vscode" }
  }
}

M.configurations = {
  cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll", vim.fn.getcwd(), "file")
      end,
    },
  }
}

return M

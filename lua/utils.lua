local M = {}

--- Path
-------------------------------------------------------------------------------

--- @param path string This string is appended onto the nvim-data path ```:lua print(vim.fn.stdpath("data"))```
M.os_correct_nvim_data_path = function(path)
  local path = vim.fn.stdpath("data") .. path
  if vim.fn.has("win32") then
    path = string.gsub(path, "/", "\\") .. ".exe"
  end
  return path
end

--- @param unix_begin string Beginning of the UNIX path
--- @param windows_begin string Beginning of the Windows path
--- @param library_path string Rest of the string appended onto the platform specific path
M.os_correct_path = function(unix_begin, windows_begin, library_path)
  local final_path = ""
  if vim.fn.has("win32") then
    final_path = windows_begin .. library_path .. ".exe"
    final_path = string.gsub(final_path, "/", "\\")
  else
    final_path = unix_begin .. library_path
  end
  return final_path
end

--- Mason
-------------------------------------------------------------------------------

--- @brief Checks if a mason package is installed by checking if the directory exists
--- @param package_name string Name of the mason package
--- @return boolean
M.mason_package_exists = function(package_name)
  local path = M.os_correct_nvim_data_path("/mason/packages/" .. package_name)
  return vim.fn.isdirectory(path)
end

--- DAP
-------------------------------------------------------------------------------

--- @param language_name string Name is inserted into the launch configuration names for identifying the correct debugger to use
--- @param adapter string Name of the adapter CASE-SENSITIVE
--- @param extended_config table|nil Replace existing entries with new values and/or extend the default DAP configuration tab within the function
M.create_dap_lang_config = function(language_name, adapter, extended_config)
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


return M

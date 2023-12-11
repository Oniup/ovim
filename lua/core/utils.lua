local M = {}

---@param module_name
---@return
M.prequire = function(module_name)
  local ok, result = pcall(require, module_name)
  if not ok and result then
    if not string.match(result, "module '" .. module_name .. "' not found:\n") then
      vim.notify("Failed to prequire:\n" .. result, vim.log.levels.ERROR)
    end
  else
    return result
  end

  return nil
end

M.autocmd_id_name = "OvimAutoCmdGroup"

M.autocmd_id = vim.api.nvim_create_augroup(
  M.autocmd_id_name, {
    clear = true
  })

M.icons = require("defaults.icons")

--- @brief Combines users defined icons and the OVims default icons together
--- and stores it. To access the final icons table
--- `require("core.utils").icons`. All plugins that requires an icon should
--- refer to this table.
M.load_icons = function()
  local usr_icons_ok, usr_icons = pcall(require, "config.icons")
  if usr_icons_ok then
    M.icons = vim.tbl_deep_extend("force", M.icons, usr_icons)
  end
end

--- @brief Inserts term shell options for target shell. If no shell is given,
--- then will use defaults. However for windows, will prioritize using pwsh
--- over powershell unless specified
---
--- @param opts table Current options table
--- @param other_shell string|table|nil Target another shell
--- @return table opts Extended options table with terminal shell options
M.set_term_shell = function(opts, other_shell)
  local shell_opts = {}
  local other_shell_success = false

  if other_shell then
    --- TODO: ...
  end

  if not other_shell_success then
    if vim.fn.has("win32") then
      shell_opts = {
        shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command " ..
            "[Console]::InputEncoding=[Console]::OutputEncoding=" ..
            "[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }
    end
  end

  return vim.tbl_deep_extend("force", opts, shell_opts)
end

M.get_all_modules_within = function(modules_path)
  local os_path = vim.fn.stdpath("config") .. "/lua/"
      .. string.gsub(modules_path, "%.", "/")

  local cmd = ""
  if vim.fn.has("win32") then
    cmd = "dir /b/a-d \"" .. string.gsub(os_path, "/", "\\") .. "\""
  else
    cmd = "ls -pUqAL \"" .. os_path .. "\""
  end

  local result = {}
  for filename in io.popen(cmd):lines() do
    filename = string.match(filename, "^(.*)%.lua$")
    table.insert(result, modules_path .. "." .. filename)
  end

  return result
end

return M

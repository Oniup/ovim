local M = {}

--- calls pcall for require to checks if the module exists. If module exists
--- @param module_name string
--- @return table|nil module
function M.prequire(module_name)
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

--- Combines users defined icons and the Ovim's default icons together
--- and stores it. To access the final icons table `require("core.utils").icons`.
--- All plugins that requires an icon should refer to this table.
function M.load_icons()
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
function M.set_term_shell(opts, other_shell)
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

function M.get_all_modules_within(modules_path)
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
    table.insert(result, { mod = modules_path .. "." .. filename, name = filename })
  end

  return result
end

function M.correct_exec(path)
  if vim.fn.has("win32") then
    return path .. ".exe"
  end
  return path
end

function M.correct_path(path)
  if vim.fn.has("win32") then
    return string.gsub(path, "/", "\\")
  end
  return path
end

function M.os_correct_path(unix, win32)
  if vim.fn.has("win32") then
    return win32
  end
  return unix
end

function M.nvim_correct_path(stdpath, unix, win)
  stdpath = vim.fn.stdpath(stdpath) .. "/"
  if vim.fn.has("win32") then
    return string.gsub(stdpath .. win, "/", "\\")
  else
    return stdpath .. unix
  end
end

function M.dapconfig_lang_template(adapter, language, overrides)
  local result = {
    name = "Launch => " .. adapter .. " " .. vim.inspect(language),
    type = adapter,
    request = "launch",
    program =
        function()
          local exec = vim.fn.getcwd() .. "/"
          exec = exec .. vim.fn.input("Path to exec: " .. exec)
          if exec and vim.fn.has("win32") then
            exec = string.gsub(exec, "/", "\\") .. ".exe"
          end
          return exec
        end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
  }

  if overrides then
    result = vim.tbl_deep_extend("force", result, overrides)
  end

  return result
end

--- Gets the full path of relative path of mason package
---@param path string Relative path from where mason is installed (stdpath("data")/mason/packages/)
---@param is_exec boolean|nil Determines whether it is an executable. nil == false in this function
function M.get_mason_package(path, is_exec)
  local result = M.correct_path(vim.fn.stdpath("data") .. "/mason/packages/" .. path)
  if is_exec then
    result = M.correct_exec(result)
  end
  return result
end

M.autocmd_id_name = "OvimAutoCmdGroup"

M.autocmd_id = vim.api.nvim_create_augroup(
  M.autocmd_id_name, {
    clear = true
  })

M.icons = require("defaults.icons")

return M

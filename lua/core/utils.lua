local M = {}

--- calls pcall for require to checks if the module exists
--- @param module_name string
--- @return table|nil module If exists with no errors, return the result, otherwise will print error if found with errors, otherwise nil
function M.prequire(module_name)
  local ok, result = pcall(require, module_name)
  if not ok and result then
    if
      not string.match(result, "module '" .. module_name .. "' not found:\n")
    then
      vim.notify("Failed to prequire:\n" .. result, vim.log.levels.ERROR)
    end
  else
    return result
  end

  return nil
end

--- For each module, calls pcall for require to check if the module exists.
--- @param module_names table
--- @return table|nil extended_module Result of all listed and then tbl_deep_extend in order
function M.prequire_extend(module_names)
  local modules = nil
  for _, module in ipairs(module_names) do
    local tbl = M.prequire(module)
    if tbl then
      if not modules then
        modules = tbl
      else
        modules = vim.tbl_deep_extend("force", modules, tbl)
      end
    end
  end
  return modules
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
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
          .. "[Console]::InputEncoding=[Console]::OutputEncoding="
          .. "[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }
    end
  end

  return vim.tbl_deep_extend("force", opts, shell_opts)
end

--- @param path string
--- @return string Path If executable, sets the correct file type at end
function M.correct_exec(path)
  if vim.fn.has("win32") then
    return path .. ".exe"
  end
  return path
end

--- @param path string
--- @return string Path If on windows, converts all / to \
function M.correct_path(path)
  if vim.fn.has("win32") then
    return string.gsub(path, "/", "\\")
  end
  return path
end

--- Chooses the correct path based on your platform
--- @param unix string Unix specific path
--- @param win32 string Windows specific path
--- @return string Path Platform specific path
function M.os_correct_path(unix, win32)
  if vim.fn.has("win32") then
    return win32
  end
  return unix
end

--- Chooses the correct path based on your platform
--- @param stdpath string Uses vim.fn.stdpath(...) to get first half of path
--- @param unix string Unix specific second half of path
--- @param win32 string Windows specific second half of path
--- @return string Path Combined stdpath with the platform specific path
function M.nvim_correct_path(stdpath, unix, win32)
  local first = vim.fn.stdpath(stdpath) .. "/"
  if vim.fn.has("win32") then
    local full = first .. win32
    return full:gsub("/", "\\")
  else
    return first .. unix
  end
end

function M.dapconfig_lang_template(adapter, language, overrides)
  local result = {
    name = "Launch => " .. adapter .. " " .. vim.inspect(language),
    type = adapter,
    request = "launch",
    program = function()
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
  local result =
    M.correct_path(vim.fn.stdpath("data") .. "/mason/packages/" .. path)
  if is_exec then
    result = M.correct_exec(result)
  end
  return result
end

function M.get_all_modules_within(modules_paths)
  if not type(modules_paths) == "table" then
    return {}
  end

  local cmds = {}
  local entries_tbl = {}

  -- Deconstruct provided paths and create platform specific commands
  for _, path in ipairs(modules_paths) do
    local cmd = vim.fn.stdpath("config")
      .. "/lua/"
      .. string.gsub(path, "%.", "/")
    if vim.fn.has("win32") then
      cmd = 'dir /b/a-d "' .. string.gsub(cmd, "/", "\\") .. '"'
    else
      cmd = 'ls -pUqAL "' .. cmd .. '"'
    end

    table.insert(cmds, cmd)
  end

  -- Insert module entries
  for i, cmd in ipairs(cmds) do
    for filename in io.popen(cmd):lines() do
      filename = string.match(filename, "^(.*)%.lua$")
      if filename then
        if not entries_tbl[filename] then
          entries_tbl[filename] = { modules_paths[i] .. "." .. filename }
        else
          table.insert(
            entries_tbl[filename],
            modules_paths[i] .. "." .. filename
          )
        end
      end
    end
  end

  return entries_tbl
end

function M.get_installed_lsp_client_names()
  local cmd = 'ls -pUqAL "' .. M.mason_install_path .. '"'
  if vim.fn.has("win32") then
      cmd = 'dir /b "' .. string.gsub(M.mason_install_path, "/", "\\") .. '"'
  end

  local servers = {}
  for client in io.popen(cmd):lines() do
    table.insert(servers, client)
  end
  return servers
end

M.autocmd_id_name = "OvimAutoCmdGroup"

M.autocmd_id = vim.api.nvim_create_augroup(M.autocmd_id_name, {
  clear = true,
})

M.icons = require("defaults.icons")

M.mason_install_path = M.correct_path(vim.fn.stdpath("data") .. "/mason/packages")

return M

local M = {}

--- Combines two option tables giving right side options priority
--- @param lhs table Default options
--- @param rhs table|nil Override/add options
---@return table opts Combined options
function M.map_opts(lhs, rhs)
  if not rhs then
    return lhs
  end

  if vim.tbl_islist(rhs) then
    for _, v in ipairs(rhs) do
      if v then
        lhs = vim.tbl_deep_extend("force", lhs, v)
      end
    end
    return lhs
  end

  lhs = vim.tbl_deep_extend("force", lhs, rhs)
  return lhs
end

--- calls pcall for require to checks if the module exists
--- @param module_name string
--- @return table|nil module If exists with no errors, return the result, otherwise will print error if found with errors, otherwise nil
function M.prequire(module_name)
  local ok, result = pcall(require, module_name)
  if not ok and result then
    if
      not string.find(
        result,
        "module '" .. module_name .. "' not found:",
        1,
        true
      )
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

function M.load_options()
  local opts = M.map_opts(require("core.options"), M.prequire("config.options"))

  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

function M.load_mappings()
  M.mappings =
    M.map_opts(require("core.mappings"), M.prequire("config.mappings"))

  vim.g.mapleader = M.mappings.leader
  vim.g.maplocalleader = M.mappings.leader

  M.set_mappings("general")
end

function M.load_ui()
  M.ui = M.map_opts(require("core.ui"), M.prequire("config.ui"))
end

function M.load_ui_modules()
  for _, module in ipairs(M.ui.load_ui_module) do
    require(module).set(M.ui)
  end
end

--- Sets loads all mappings within the given table using vim.keymap.set(...)
--- @param tbl_key string Mapping group name
--- @param override_opts table|nil A third option overrides for specific cases
function M.set_mappings(tbl_key, override_opts)
  local registered = M.mappings[tbl_key]

  if registered then
    for mode, mappings in pairs(registered) do
      for key, map in pairs(mappings) do
        local cmd = map[1]
        local desc = map[2]
        local opts = M.mappings.default_opts

        if map["opts"] then
          opts = M.map_opts(opts, map["opts"])
        end
        if desc and type(desc) == "string" then
          opts["desc"] = desc
        end

        vim.keymap.set(mode, key, cmd, M.map_opts(opts, override_opts))
      end
    end

    return true
  end

  return false
end

function M.get_mapped_plugin_config(name)
  local core = M.prequire("plugins.configs." .. name)
  local override = M.prequire("config.plugins.configs" .. name)

  if core then
    return M.map_opts(core, override)
  elseif override then
    return override
  end

  return nil
end

function M.stripped_plugin_name(name)
  local common_ignore = { "lua", "nvim", "vim" }
  for _, str in ipairs(common_ignore) do
    name = string.gsub(name, "%." .. str, "")
  end
  return name
end

function M.load_plugins()
  require("core.plugins").load_lazy_plugins()
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

M.mason_install_path = vim.fn.stdpath("data") .. "/mason/packages"

return M

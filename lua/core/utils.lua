local M = {}

M.mason_install_path = vim.fn.stdpath("data") .. "/mason/packages"

--- Combines two option tables giving right side options priority
--- @param lhs table Default options
--- @param rhs table|nil Override/add options
---@return table opts Combined options
function M.map_tbl(lhs, rhs)
  if rhs then
    if vim.tbl_islist(rhs) then
      for _, v in pairs(rhs) do
        if v ~= nil then
          lhs = vim.tbl_deep_extend("force", lhs, v)
        end
      end
    else
      lhs = vim.tbl_deep_extend("force", lhs, rhs)
    end
  end
  return lhs
end

--- calls pcall for require to checks if the module exists
--- @param module_name string
--- @return table|nil module If exists with no errors, return the result, otherwise will print error if found with errors, otherwise nil
function M.prequire(module_name)
  local ok, result = pcall(require, module_name)
  if not ok and result then
    if not string.find(result, "module '" .. module_name .. "' not found:", 1, true) then
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
  local modules = {}
  for _, module in ipairs(module_names) do
    local tbl = M.prequire(module)
    if type(tbl) == "table" then
      modules = M.map_tbl(modules, tbl)
    else
      vim.notify("Cannot combine module " .. module .. ", it doesn't return a table", vim.log.levels.ERROR)
    end
  end
  return modules
end

function M.os_correct_exec(path)
  if vim.fn.has("win32") then
    return path .. ".exe"
  end
  return path
end

function M.load_options()
  local opts = M.map_tbl(require("core.options"), M.prequire("custom.options"))
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

function M.load_mappings()
  M.mappings = M.map_tbl(require("core.mappings"), M.prequire("custom.mappings"))
  vim.g.mapleader = M.mappings.leader
  vim.g.maplocalleader = M.mappings.leader
  M.set_mappings("general")
end

function M.load_ui()
  M.ui = M.map_tbl(require("core.ui"), M.prequire("custom.ui"))
end

function M.load_colorscheme()
  vim.cmd.colorscheme(M.ui.colorscheme.theme)
  if not vim.tbl_isempty(M.ui.colorscheme.hl_overrides) then
    for k, v in pairs(M.ui.colorscheme.hl_overrides) do
      vim.api.nvim_set_hl(0, k, v)
    end
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
          opts = M.map_tbl(opts, map["opts"])
        end
        if desc and type(desc) == "string" then
          opts["desc"] = desc
        end

        vim.keymap.set(mode, key, cmd, M.map_tbl(opts, override_opts))
      end
    end
    return true
  end
  return false
end

function M.get_mapped_plugin_config(name)
  return M.map_tbl({}, {
    M.prequire("plugins.configs." .. name),
    M.prequire("custom.plugins.configs." .. name),
  })
end

function M.stripped_plugin_name(name)
  local common_ignore = { "lua", "nvim", "vim" }
  for _, str in ipairs(common_ignore) do
    name = string.gsub(name, "%." .. str, "")
  end
  return name
end

function M.load_plugins()
  local opts = M.get_mapped_plugin_config("lazy_nvim")
  require("core.plugins").load_lazy_plugins(opts)
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

function M.dap_config_template(adapter, language, overrides)
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

  result = M.map_tbl(result, overrides)
end

return M

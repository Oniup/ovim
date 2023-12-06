local M = {}

M.default_opts = { silent = true }
M.plugin_keymaps = {}

M.expand_cmd = function(cmd)
  local result = {}
  local first = true
  for i = 1, #cmd do
    if first then
      first = false
      if type(cmd[i]) == "string" or type(cmd[i]) == "function" then
        result.exec = cmd[i]
      else
        result.error_msg = "Invalid keymap, first argument in cmd must be either a string or function"
        return result
      end
    else
      if type(cmd[i]) == "string" then
        result.desc = cmd[i]
      elseif type(cmd[i]) == "table" then
        result.opts = cmd[i]
      end
    end
  end
  if result.exec == nil then
    result.error_msg = "Invalid keymap, first argument in cmd must be either a string of function to define the keymaps purpose"
  end
  if result.opts == nil then
    result.opts = M.default_opts
  else
    result.opts = vim.tbl_deep_extend("force", result.opts, M.default_opts)
  end
  return result
end

M.load_keymap_mode = function(mode, keymaps)
  -- vim.notify("keymap for mode " .. mode .. ": " .. vim.inspect(keymaps), vim.log.levels.INFO)
  if keymaps ~= nil then
    for input, cmd in pairs(keymaps) do
      if type(cmd) == "table" and #cmd > 0 then
        local expanded = M.expand_cmd(cmd)
        if expanded.error_msg == nil then
          -- vim.notify("mode: " .. mode .. ", input: " .. input .. ":\n" .. vim.inspect(expanded), vim.log.levels.INFO)
          vim.keymap.set(mode, input, expanded.exec, expanded.opts)
          -- TODO: Implement which-key plugin and auto add keymap desc if entered
        else
          vim.notify("Invalid keymap for input `" .. input .. ", expanded cmd:\n" .. vim.inspect(expanded), vim.log.levels.ERROR)
        end
      else
        vim.notify("Invalid keymap for input `" .. input ..
          "`. Cmd provided should be a table:\n" .. cmd, vim.log.levels.ERROR)
      end
    end
  end
end

M.load_keymaps = function()
  local keymaps = require("defaults.keymaps")
  local usr_keymaps_ok, usr_keymaps = pcall(require, "config.keymaps")
  if usr_keymaps_ok then
    -- vim.notify(vim.inspect(usr_keymaps), vim.log.levels.INFO)
    keymaps = vim.tbl_deep_extend("force", keymaps, usr_keymaps)
  end
  local keymap_modes = { "n", "v", "i", "t", "c" }
  for k, v in pairs(keymaps) do
    if vim.tbl_contains(keymap_modes, k) then
      M.load_keymap_mode(k, v)
    elseif k == "leader" then
      -- vim.notify("set the leader to: `" .. v .. "`", vim.log.levels.INFO)
      vim.g.mapleader = v
      vim.g.maplocalleader = v
    else
      -- vim.notify("plugin `" .. k .. "` keymaps:\n" .. vim.inspect(v), vim.log.levels.INFO)
      M.plugin_keymaps[k] = v
    end
  end
end

M.load_lazy = function(plugin)
  -- TODO: ...
end

return M

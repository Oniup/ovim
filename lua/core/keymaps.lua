local M = {}

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
    result.error_msg =
    "Invalid keymap, first argument in cmd must be either a string of function to define the keymaps purpose"
  end

  if not result.opts then
    result.opts = { silent = false }
  else
    result.opts = vim.tbl_deep_extend("force", result.opts, { silent = false })
  end

  return result
end

M.load_mode_keymaps = function(mode, keymaps)
  if keymaps ~= nil then
    for input, cmd in pairs(keymaps) do
      if type(cmd) == "table" and #cmd > 0 then
        local expanded = M.expand_cmd(cmd)

        if expanded.error_msg == nil then
          vim.keymap.set(mode, input, expanded.exec, expanded.opts)
        else
          vim.notify("Invalid keymap for input " .. vim.inspect(input) ..
            ", expanded cmd:\n" .. vim.inspect(expanded), vim.log.levels.ERROR)
        end
      else
        vim.notify(
          "Invalid keymap for input " .. vim.inspect(input) ..
          ". Cmd provided should be a table:\n" .. vim.inspect(cmd),
          vim.log.levels.ERROR
        )
      end
    end
  end
end

M.plugin_keymaps_autocmd_setup = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(evt)
      local plug_name = evt.data
      local keymaps = M.plugin_keymaps[plug_name]
      if not keymaps then
        return
      end

      --vim.notify(vim.inspect(evt), vim.log.levels.INFO)

      for m, mkeymaps in pairs(keymaps) do
        M.load_mode_keymaps(m, mkeymaps)
      end
    end,
  })
end

M.load_keymaps = function()
  local keymaps = require("defaults.keymaps")

  local usr_keymaps_ok, usr_keymaps = pcall(require, "config.keymaps")
  if usr_keymaps_ok then
    -- vim.notify(vim.inspect(usr_keymaps), vim.log.levels.INFO)
    keymaps = vim.tbl_deep_extend("force", keymaps, usr_keymaps)
  end

  -- vim.notify(vim.inspect(keymaps), vim.log.levels.INFO)

  local keymap_modes = { "n", "v", "i", "t", "c", "x" }
  for mode, maps in pairs(keymaps) do
    if vim.tbl_contains(keymap_modes, mode) then
      M.load_mode_keymaps(mode, maps)
    elseif mode == "leader" then
      -- vim.notify("set the leader to: `" .. maps .. "`", vim.log.levels.INFO)
      vim.g.mapleader = maps
      vim.g.maplocalleader = maps
    else
      -- vim.notify("plugin `" .. mode .. "` keymaps:\n" .. vim.inspect(maps), vim.log.levels.INFO)
      M.plugin_keymaps[mode] = maps
    end
  end
end

return M

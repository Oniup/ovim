local M = {}

M.keymaps = {}

M.create_keymap = function(mode, binding, bound)
  local error_message = function(msg)
    vim.notify(msg .. ". " .. vim.inspect(mode) .. " => " .. vim.inspect(binding) .. " = " .. vim.inspect(bound))
  end
  local opts = { silent = false }
  local exec = nil
  local desc = nil

  if not type(bound) == "table" then
    error_message("Binding must be a table")
    return
  end

  -- Extracting bound
  for i = 1, #bound do
    if i == 1 then
      if type(bound[i]) == "string" or type(bound[i]) == "function" then
        exec = bound[i]
      else
        error_message("First element in binding must be either a string or function")
        return
      end
    else
      if type(bound[i]) == "string" then
        desc = bound[i]
      elseif type(bound[i]) == "table" then
        opts = vim.tbl_extend("force", opts, bound[i])
      end
    end
  end

  if not exec then
    error_message("Keybinding executable is nil")
    return
  end

  vim.notify(mode .. " => " .. vim.inspect(binding) .. " = " .. vim.inspect(exec) .. " " .. vim.inspect(opts))
  vim.api.nvim_set_keymap(mode, binding, exec, opts)
end

M.init_keymaps = function(target)
  local mappings = M.keymaps[target]
  if not mappings then
    vim.notify("Target keymaps " .. target .. " doesn't exist or has not been loaded", vim.log.levels.ERROR)
  end

  if target == "leader" then
    vim.g.mapleader = mappings
    vim.g.maplocalleader = mappings

    return
  elseif type(mappings) == "table" then
    local modes = { "i", "n", "x", "v", "t", "c" }

    for mode, map in pairs(mappings) do
      if vim.tbl_contains(modes, mode) then
        for binding, bound in pairs(map) do
          M.create_keymap(mode, binding, bound)
        end
      else
        vim.notify("Given mode \"" .. mode .. "\" is not a valid vim mode", vim.log.levels.ERROR)
      end
    end

    return
  else
    vim.notify("Mappings is the wrong type (" .. type(mappings) .. ")", vim.log.levels.ERROR)
  end
end

M.init_plugin_keymaps = function(plugin_name)
  local mappings = M.keymaps.plugins[plugin_name]
  if not mappings then
    return
  end

  M.init_keymaps(mappings)
end

M.create_plugin_keymap_init_autocmd = function()
end

M.load_keymaps = function()
  M.keymaps = require("defaults.keymaps")
  local usr_ok, usr_keymaps = pcall(require, "config.keymaps")

  if usr_ok then
    M.keymaps = vim.tbl_extend("force", M.keymaps, usr_keymaps)
  end

  M.init_keymaps("general")
  M.init_keymaps("leader")
end

return M

local M = {}

M.plugin_keymaps = {}

M.set_keymap = function(mode, key, map)
  local cmd = map[1]
  local opts = map.opts
  local desc = map.desc

  if not opts then
    opts = M.default_opts
  else
    opts = vim.tbl_deep_extend("force", M.default_opts, opts)
  end

  vim.keymap.set(mode, key, cmd, opts)
end

M.plugin_keymaps_autocmd_setup = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(evt)
      local plugin_name = evt.data
      local keymaps = M.plugin_keymaps[plugin_name]
      if not keymaps then
        return
      end

      -- vim.notify(vim.inspect(evt), vim.log.levels.INFO)

      for mode, mappings in pairs(keymaps) do
        if vim.tbl_contains(M.mapping_modes, mode) then
          -- vim.notify(vim.inspect(mode) .. " -> " .. vim.inspect(mappings) .. "\n Extracted:", vim.log.levels.ERROR)
          for key, map in pairs(mappings) do
            M.set_keymap(mode, key, map)
          end
        end
      end
    end,
  })
end

M.load_keymaps = function()
  local keymaps = require("defaults.keymaps")
  -- vim.notify(vim.inspect(keymaps), vim.log.levels.ERROR)

  local usr_keymaps_ok, usr_keymaps = pcall(require, "config.keymaps")
  if usr_keymaps_ok then
    -- vim.notify(vim.inspect(usr_keymaps), vim.log.levels.INFO)
    -- keymaps = require("core.utils").tbl_extend(keymaps, usr_keymaps)
    keymaps = vim.tbl_deep_extend("force", keymaps, usr_keymaps)
  end

  -- vim.notify(vim.inspect(keymaps), vim.log.levels.ERROR)

  M.mapping_modes = keymaps["mapping_modes"]
  M.default_opts = keymaps["default_opts"]
  M.plugin_keymaps = keymaps["plugins"]
  M.general_keymaps = keymaps["general"]

  for mode, mappings in pairs(M.general_keymaps) do
    if vim.tbl_contains(M.mapping_modes, mode) and type(mappings) == "table" then
      for key, map in pairs(mappings) do
        M.set_keymap(mode, key, map)
      end
    end
  end
end

return M

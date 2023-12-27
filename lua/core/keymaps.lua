local M = {}

M.set_keymap = function(mode, key, map)
  local cmd = map[1]
  local opts = {}

  if not map.opts then
    opts = M.default_opts
  else
    opts = vim.tbl_deep_extend("force", M.default_opts, map.opts)
  end
  if map.desc then
    opts["desc"] = map.desc
  end

  vim.keymap.set(mode, key, cmd, opts)
end

--- @param plugin_name string
function M.set_plugin_keymap(plugin_name)
  local keymaps = M.plugin_keymaps[plugin_name]
  local plugin_keymaps = {}

  if keymaps then
    for mode, mappings in pairs(keymaps) do
      if type(mappings) == "table" then
        for key, map in pairs(mappings) do
          local cmd = map[1]
          local opts = {}

          if not map.opts then
            opts = M.default_opts
          else
            opts = vim.tbl_deep_extend("force", M.default_opts, map.opts)
          end
          if not map.desc then
            map.desc = "~"
          end

          table.insert(plugin_keymaps, { key, cmd, desc = map.desc, mode = mode })
        end
      end
    end

    plugin_keymaps[plugin_name] = nil
  end

  if #plugin_keymaps > 0 then
    return plugin_keymaps
  end
  return nil
end

M.load_keymaps = function()
  local keymaps = require("defaults.keymaps")

  local usr_keymaps = require("core.utils").prequire("config.keymaps")
  if usr_keymaps then
    keymaps = vim.tbl_deep_extend("force", keymaps, usr_keymaps)
  end

  M.mapping_modes = keymaps["mapping_modes"]
  M.default_opts = keymaps["default_opts"]
  M.plugin_keymaps = keymaps["plugins"]

  for mode, mappings in pairs(keymaps["general"]) do
    if vim.tbl_contains(M.mapping_modes, mode) and type(mappings) == "table" then
      for key, map in pairs(mappings) do
        M.set_keymap(mode, key, map)
      end
    end
  end
end

return M

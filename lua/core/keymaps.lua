local M = {}

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

      for mode, mappings in pairs(keymaps) do
        if vim.tbl_contains(M.mapping_modes, mode) then
          for key, map in pairs(mappings) do
            M.set_keymap(mode, key, map)
          end
        end
      end

      M.plugin_keymaps[plugin_name] = nil
    end,
  })
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

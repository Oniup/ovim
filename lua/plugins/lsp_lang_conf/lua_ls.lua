local M = {}

M.enable_keybindings = function()
end

M.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" }
    },
    -- for formatting options: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
    format = {
      enable = true,
    },
  },
}

return M

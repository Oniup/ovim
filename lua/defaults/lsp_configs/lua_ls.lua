local M = {}

M.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" }
    },
    -- for formatting options: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
    format = {
      enable = true,
    },
    completion = {
      callSnippet = "Replace",
    },
  },
}

return M

return {
  Lua = {
    diagnostics = {
      globals = { "vim" }
    },
    -- for formatting options: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
    format = {
      enable = true,
      defaultConfig = {
        indent_style = "space",
        indent_size = 4,
        max_line_length = 80,
        align_continuous_inline_comment = false,
      },
    },
  },
}

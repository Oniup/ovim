local M = {}

M.plugin = {
  "ray-x/lsp_signature.nvim",
  opts = {
    bind = true,

    doc_lines = 15,
    max_height = 16,
    max_width = 88,
    wrap = true,

    floating_window = true, -- setting to false will only use virtual text
    floating_window_above_cur_line = true,
    floating_window_off_x = 5,
    floating_window_off_y = 0,
    fix_pos = false,

    hint_enable = false, -- virtual hint enable
    hint_prefix = "",
    hint_scheme = "String",
    hint_inline = function() return false end,
    hi_parameter = "LspSignatureActiveParameter",

    handler_opts = {
      border = require("core.utils").icons.border
    },
    padding = " ",
  },
}

return M

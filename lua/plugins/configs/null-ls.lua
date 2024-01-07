local M = {}

local builtins = require("null-ls.builtins")

M.opts = {
  debug = true,
  sources = {
    builtins.formatting.stylua,
    builtins.formatting.clang_format,
  },
}

return M

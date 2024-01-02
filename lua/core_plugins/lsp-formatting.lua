local M = {}

M.plugin = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = function()
    local builtins = require("null-ls.builtins")
    return {
      debug = true,
      sources = {
        builtins.formatting.stylua,
        builtins.formatting.clang_format,
        builtins.completion.spell,
      },
    }
  end,
}

return M

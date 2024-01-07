local M = {}

local u = require("core.utils")

function M.set(opts)
  require("lspconfig.ui.windows").default_options = {
    border = u.icons.border,
  }

  for _, sign in ipairs({
    { name = "DiagnosticSignError", text = u.icons.diagnostics.error },
    { name = "DiagnosticSignWarn", text = u.icons.diagnostics.warn },
    { name = "DiagnosticSignHint", text = u.icons.diagnostics.hint },
    { name = "DiagnosticSignInfo", text = u.icons.diagnostics.info },
  }) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = "",
    })
  end

  vim.diagnostic.config(opts.diagnostics)
end

return M

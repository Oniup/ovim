local M = {}

function M.set(opts)
  require("lspconfig.ui.windows").default_options = {
    border = opts.border.type,
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = opts.border.type,
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = opts.border.type,
      focusable = false,
      relative = "cursor",
    }
  )

  for _, sign in ipairs({
    { name = "DiagnosticSignError", text = opts.icons.diagnostics.error },
    { name = "DiagnosticSignWarn", text =  opts.icons.diagnostics.warn },
    { name = "DiagnosticSignHint", text =  opts.icons.diagnostics.hint },
    { name = "DiagnosticSignInfo", text =  opts.icons.diagnostics.info },
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

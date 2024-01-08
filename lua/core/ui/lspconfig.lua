local M = {}

local ui = require("core.utils").ui

function M.set_popup_window()
  require("lspconfig.ui.windows").default_options = {
    border = ui.border.type,
  }
end

function M.set_handlers()
  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = ui.border.type,
    })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = ui.border.type,
      focusable = false,
      relative = "cursor",
    })
end

function M.set_diagnostics()
  for _, sign in ipairs({
    { name = "DiagnosticSignError", text = ui.icons.diagnostics.error },
    { name = "DiagnosticSignWarn", text = ui.icons.diagnostics.warn },
    { name = "DiagnosticSignHint", text = ui.icons.diagnostics.hint },
    { name = "DiagnosticSignInfo", text = ui.icons.diagnostics.info },
  }) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = "",
    })
  end

  vim.diagnostic.config(ui.diagnostics)
end

function M.load()
  M.set_popup_window()
  M.set_handlers()
  M.set_diagnostics()
end

return M
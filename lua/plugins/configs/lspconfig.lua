local M = {}

local u = require("core.utils")
local ui = require("core.utils").ui

function M.ui_set_popup_window()
  require("lspconfig.ui.windows").default_options = {
    border = ui.border.type,
  }
end

function M.ui_set_handlers()
  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = ui.border.type,
    })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = ui.border.type,
      focusable = false,
    })
end

function M.ui_set_diagnostics()
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

  vim.diagnostic.config(ui.lsp)
end

function M.load_ui()
  M.ui_set_popup_window()
  M.ui_set_handlers()
  M.ui_set_diagnostics()
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

function M.on_attach(client, bufnr)
  local opts = { buffer = bufnr }
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  u.set_mappings("lsp", opts)
  u.set_mappings("lsp_" .. client.name, opts)
end

M.opts = {
  lspconfig = {
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  },
}

function M.loaded_callback(config)
  local opts = config.opts

  require("mason-lspconfig").setup_handlers({
    function(server)
      local server_opts = {
        on_attach = opts.lspconfig.on_attach,
        capabilities = opts.lspconfig.capabilities,
        settings = u.map_tbl({}, {
          u.prequire("plugins.lspconfigs." .. server),
          u.prequire("custom.plugins.lspconfigs." .. server),
        }),
      }
      require("lspconfig")[server].setup(server_opts)
    end,
  })

  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("LspConfigCheckFile", {}),
    callback = function()
      local this = vim.fn.expand("%")
      local not_allowed = { "NvimTree_1", "[lazy]", "[mason]", "" }
      for _, ft in ipairs(not_allowed) do
        if this == ft then
          return
        end
      end
      vim.cmd([[silent! do FileType]])
    end,
  })

  M.load_ui()
end

return M

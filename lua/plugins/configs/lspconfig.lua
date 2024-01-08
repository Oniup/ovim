local M = {}

local u = require("core.utils")

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
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local opts = { buffer = bufnr }
  u.set_mappings("lsp", opts)
  u.set_mappings("lsp_" .. client, opts)
end

M.opts = {
  lspconfig = {
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  },
  ui = {
    diagnostics = {
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        border = u.ui.border.type,
        source = "always",
        header = "",
        prefix = "",
      },
    },
  },
}

function M.setup(_, opts)
  local modules_paths = u.get_all_modules_at({
    "custom.plugins.lspconfigs",
    "plugins.lspconfigs",
  })

  require("mason-lspconfig").setup_handlers({
    function(server)
      local server_opts = {
        on_attach = opts.lspconfig.on_attach,
        capabilities = opts.lspconfig.capabilities,
      }

      for name, modules in pairs(modules_paths) do
        if name == server then
          local settings = {}
          for _, module in ipairs(modules) do
            settings = u.map_opts(settings, u.prequire(module))
          end
          server_opts.settings = settings
        end
      end

      require("lspconfig")[server].setup(server_opts)
    end,
  })
end

return M

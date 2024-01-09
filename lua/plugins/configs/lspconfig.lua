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
  local opts = { buffer = bufnr }
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
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

function M.loaded_callback(config)
  local opts = config.opts

  require("mason-lspconfig").setup_handlers({
    function(server)
      local server_opts = {
        on_attach = opts.lspconfig.on_attach,
        capabilities = opts.lspconfig.capabilities,
        settings = u.map_opts({}, {
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
end

return M

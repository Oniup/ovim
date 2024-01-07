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
  local telescope = require("telescope.builtin")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  local opts = { buffer = bufnr, noremap = true }
end

function M.load_lsp_client_configs(on_attach, capabilities)
  local modules_paths = u.get_all_modules_within({
    "config.lsp_configs",
    "defaults.lsp_configs",
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local client_config = {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- TODO: Load language and lsp keymaps
        end,
        capabilities = capabilities,
      }

      for name, modules in pairs(modules_paths) do
        if name == server_name then
          local client_opts = u.prequire_extend(modules)
          if client_opts then
            client_config.settings = client_opts.settings
          end
        end
      end

      require("lspconfig")[server_name].setup(client_config)
    end,
  })
end

function M.lspconfig_ui(opts)
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

M.opts = {
 --  mason = {
 --    ui = {
 --      icons = u.icons.mason,
 --      border = u.icons.border,
 --    },
 --  },
 --  ensure_installed = {
 --    -- Language servers
 --    "lua_ls",
 --    "vim-language-server",
 --    "json-lsp",
 --    "misspell",
 -- 
 --    -- Formatters and linters
 --    "stylua",
 --  },
 --  mason_tools = {
 --    auto_update = true,
 --    run_on_start = true, -- Automatically install / update on startup.
 --    start_delay = 3000, -- Set a delay (in ms) before the installation starts
 --    debounce_hours = 5, -- Set to 0 if run_on_start == false
 --  },
 --  lspconfig = {
  capabilities = capabilities,
  on_attach = on_attach,
  ui = {
    diagnostics = {
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        border = u.icons.border,
        source = "always",
        header = "",
        prefix = "",
      },
    },
  },
  -- },
}

M.setup = false

function M.setup_callback(config)
  -- require("mason").setup(opts.mason)
  -- require("mason-lspconfig").setup()
  -- require("mason-tool-installer").setup({
  --   ensure_installed = opts.ensure_installed,
  -- })

  -- M.load_lsp_client_configs(
  --   opts.lspconfig.on_attach,
  --   opts.lspconfig.capabilities
  -- )

  M.lspconfig_ui(config.opts.ui)
end

return M

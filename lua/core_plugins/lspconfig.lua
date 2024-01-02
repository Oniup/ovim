local M = {}
local utils = require("core.utils")
local icons = utils.icons

function M.default_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem = {
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

  return capabilities
end

function M.default_on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  local telescope = require("telescope.builtin")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- TODO: Have this with all the other keybindings
  vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
  vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
  vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts)
  vim.keymap.set("n", "gr", telescope.lsp_references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>di", telescope.diagnostics, opts)
  vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts)
end

function M.get_lspconfig_server_opts(server)
  local usr_lang_config = utils.prequire("config.lsp_configs." .. server)
  local lang_config = utils.prequire("defaults.lsp_configs." .. server)

  if usr_lang_config then
    if lang_config and not usr_lang_config.no_extend_default then
      lang_config = vim.tbl_deep_extend("force", lang_config, usr_lang_config)
    else
      lang_config = usr_lang_config
    end
  end

  return lang_config
end

function M.load_lspconfig_server(server)
  local config = {
    on_attach = M.default_on_attach,
    capabilities = M.default_capabilities(),
  }

  local custom_config = M.get_lspconfig_server_opts(server)
  if custom_config then
    config = vim.tbl_deep_extend("force", config, custom_config)
  end

  require("lspconfig")[server].setup(config)
end

M.plugin = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
    "nvimtools/none-ls.nvim",
  },
  lazy = false,
  opts = {
    mason = {
      ui = {
        icons = icons.mason,
        border = icons.border,
      },
    },
    mason_lspconfig = {
      ensure_installed = {
        "lua_ls",
      },
    },
    mason_lspconfig_handlers = {
      M.load_lspconfig_server,
    },
    display = {
      diagnostics = {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          border = icons.border,
          source = "always",
          header = "",
          prefix = "",
        },
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup(opts.mason_lspconfig)
    require("mason-lspconfig").setup_handlers(opts.mason_lspconfig_handlers)

    require("lspconfig.ui.windows").default_options = {
      border = icons.border,
    }

    for _, sign in ipairs({
      { name = "DiagnosticSignError", text = icons.diagnostics.error },
      { name = "DiagnosticSignWarn", text = icons.diagnostics.warn },
      { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
      { name = "DiagnosticSignInfo", text = icons.diagnostics.info },
    }) do
      vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = "",
      })
    end

    vim.diagnostic.config(opts.display.diagnostics)
    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = icons.border,
        focusable = true,
      })
  end,
}

return M

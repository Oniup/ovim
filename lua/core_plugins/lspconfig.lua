local M = {}
local utils = require("core.utils")
local icons = utils.icons

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

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  local telescope = require("telescope.builtin")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- TODO: Remove when improving loading keymaps
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

function M.load_lsp_client_configs(on_attach, capabilities)
  local modules_paths = utils.get_all_modules_within({
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
          local client_opts = utils.prequire_extend(modules)
          if client_opts then
            client_config.settings = client_opts.settings
          end
        end
      end

      require("lspconfig")[server_name].setup(client_config)
    end,
  })
end

function M.lspconfig_ui(config)
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

  vim.diagnostic.config(config.diagnostics)
end

M.plugin = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvimtools/none-ls.nvim",
    "stevearc/dressing.nvim",
  },
  lazy = false,
  opts = {
    mason = {
      ui = {
        icons = icons.mason,
        border = icons.border,
      },
    },
    ensure_installed = {
      -- Language servers
      "lua_ls",
      "vim-language-server",
      "json-lsp",
      "misspell",

      -- Formatters and linters
      "stylua",
    },
    mason_tools = {
      auto_update = true,
      run_on_start = true, -- Automatically install / update on startup.
      start_delay = 3000, -- Set a delay (in ms) before the installation starts
      debounce_hours = 5, -- Set to 0 if run_on_start == false
    },
    lspconfig = {
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
            border = icons.border,
            source = "always",
            header = "",
            prefix = "",
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup()
    require("mason-tool-installer").setup({
      ensure_installed = opts.ensure_installed,
    })

    M.load_lsp_client_configs(
      opts.lspconfig.on_attach,
      opts.lspconfig.capabilities
    )

    M.lspconfig_ui(opts.lspconfig.ui)
  end,
}

return M

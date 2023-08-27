return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    "m-demare/hlargs.nvim",
    "folke/neodev.nvim",
  },
  lazy = false,
  priority = 999,

  config = function()
    local signs = {
      { name = "DiagnosticSignError", text = "󰅚 " },
      { name = "DiagnosticSignWarn", text = "󰀪 " },
      { name = "DiagnosticSignHint", text = "󰌶" },
      { name = "DiagnosticSignInfo", text = " " },
    }

    for i = 1, #signs do
      vim.fn.sign_define(signs[i].name, {
        texthl = signs[i].name,
        text = signs[i].text,
        numhl = ""
      })
    end

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
      }
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      focusable = false,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
      border = "single",
      focusable = false,
      relative = "cursor",
    })

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
        border = "single",
      }
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "cmake", "lua_ls", "rust_analyzer", "omnisharp",
        "pyright", "marksman"
      },
    })

    require("mason-lspconfig").setup_handlers({
      function(server)
        local lspconfig = require("lspconfig")
        local config = {
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

            vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
          end,
          capabilities = require("cmp_nvim_lsp").default_capabilities()
        }

        local settings_exist, server_settings = pcall(
          require,
          "plugins.lsp_lang_conf." .. server
        )
        if settings_exist then
          config.settings = server_settings
        end

        lspconfig[server].setup(config)
      end
    })
  end,
}

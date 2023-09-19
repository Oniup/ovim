return {
  "williamboman/mason.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",

    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "folke/neodev.nvim",
    "filipdutescu/renamer.nvim",
  },
  lazy = false,
  priority = 999, -- initialized after color theme

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
      border = "rounded",
      focusable = false,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
      border = "rounded",
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
        border = "rounded",
      }
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "cmake", "lua_ls", "rust_analyzer", "omnisharp",
        "pyright", "marksman"
      },
    })

    local renamer = require("renamer")
    renamer.setup()

    require("mason-lspconfig").setup_handlers({
      function(server)
        local lspconfig = require("lspconfig")
        local config = {
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }
            local telescope = require("telescope.builtin")
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
            vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
            vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts)
            vim.keymap.set("n", "gr", telescope.lsp_references, opts)
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>di", telescope.diagnostics, opts)
            vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            -- vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>re", renamer.rename, opts)
            vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts)
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

    require("lspconfig.ui.windows").default_options = {
      border = "rounded",
    }
  end,
}

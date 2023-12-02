return {
  "williamboman/mason.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",

    --- LSP Plugins
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "stevearc/dressing.nvim",
  },
  lazy = false,
  priority = 999, -- initialized after color theme
  config = function()
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
        "clangd", "cmake", "lua_ls", "pyright",
      },
    })

    --- LSP Diagnostics
    ---------------------------------------------------------------------------
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
        border = "single",
        source = "always",
        header = "",
        prefix = ""
      }
    })

    --- LSP Handlers
    ---------------------------------------------------------------------------

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      focusable = false,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
      border = "single",
      focusable = false,
      relative = "cursor",
    })

    --- LSP and Keybindings
    ---------------------------------------------------------------------------
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
            vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts)
          end,
          capabilities = require("cmp_nvim_lsp").default_capabilities()
        }

        local lsp_custom_config_exists, lsp_custom_config = pcall(require, "plugins.lsp_lang_conf." .. server)
        if lsp_custom_config_exists then
          lsp_custom_config.enable_keybindings()
          if lsp_custom_config.settings ~= nil then
            config.settings = lsp_custom_config.settings
          end
        end
        lspconfig[server].setup(config)
      end
    })

    --- Other Lsp Plugins
    ---------------------------------------------------------------------------
    require("lspconfig.ui.windows").default_options = {
      border = "single",
    }

    require("dressing").setup({
      mappings = {
        n = {
          ["qq"] = "Close",
        },
        i = {
          ["qq"] = "Close",
        },
      }
    })
  end
}

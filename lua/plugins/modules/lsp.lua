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

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      }
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "cmake", "lua_ls", "rust_analyzer", "omnisharp",
        "pyright", "marksman"
      }
    })

    require("mason-lspconfig").setup_handlers({
      function(server)
        local lspconfig = require("lspconfig")
        local config = {
          on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            vim.keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            vim.keymap.set("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
            vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
            vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            vim.keymap.set("n", "<leader>re", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
            vim.keymap.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
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

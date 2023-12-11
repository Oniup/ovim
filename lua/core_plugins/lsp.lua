local ovim_icons = require("core.utils").icons
local M = {}

M.name = "lsp"

M.info = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",

    -- Other LSP modules
    "neovim/nvim-lspconfig",
    "stevearc/dressing.nvim",
    "linrongbin16/lsp-progress.nvim",
    "folke/neodev.nvim",

    -- Other
    "telescope/telescope.nvim",
    "ms-jpq/coq_nvim"
  },
  lazy = false,
  priority = 999, -- initialized after color theme
  config = function()
    local signs = {
      { name = "DiagnosticSignError", text = ovim_icons.diagnostics.error },
      { name = "DiagnosticSignWarn",  text = ovim_icons.diagnostics.warn },
      { name = "DiagnosticSignHint",  text = ovim_icons.diagnostics.hint },
      { name = "DiagnosticSignInfo",  text = ovim_icons.diagnostics.info },
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
        border = ovim_icons.border,
        source = "always",
        header = "",
        prefix = ""
      }
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = ovim_icons.border,
      focusable = false,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
      border = ovim_icons.border,
      focusable = false,
      relative = "cursor",
    })

    require("mason").setup(M.mason_opts)
    require("mason-lspconfig").setup(M.mason_lsp_config_opts)
    require("mason-lspconfig").setup_handlers(M.mason_lspconfig_setup_handlers)

    require("lspconfig.ui.windows").default_options = {
      border = ovim_icons.border,
    }

    require("dressing").setup(M.dressing_opts)
    require("lsp-progress").setup(M.lsp_progress_opts)
  end
}

M.mason_opts = {
  ui = {
    icons = ovim_icons.mason,
    border = ovim_icons.border
  }
}

M.mason_lspconfig_opts = {
  ensure_installed = {
    "clangd", "cmake", "lua_ls", "pyright",
  },
}

M.mason_lspconfig_setup_handlers = {
  function(server)
    local lspconfig = require("lspconfig")
    local config = {
      on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        local telescope = require("telescope.builtin")
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
      end,

      -- capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities = require("coq").lsp_ensure_capabilities()
    }

    --- Load Language Settings
    local usr_lsp_config_ok, usr_lang_config = pcall(require, "config.lsp_configs." .. server)
    local lang_config_ok, lang_config = pcall(require, "defaults.lsp_configs." .. server)

    if usr_lsp_config_ok and lang_config_ok then
      config.settings = vim.tbl_deep_extend("force", lang_config.lang_settings, usr_lang_config.lang_settings)
    elseif lang_config_ok then
      config.settings = lang_config.lang_settings
    elseif usr_lsp_config_ok then
      config.settings = usr_lang_config.lang_settings
    end

    --- Load keybindings
    -- TODO: ...


    --- Enable Neovim Dev environment through usr_lua_settings
    if server == "lua_ls" then
      -- if usr_lang_config and usr_lang_config.enable_neodev then
      --   require("neodev").setup()
      -- end
      require("neodev").setup() -- Make sure to comment and uncomment above when committing to repo
    end

    lspconfig[server].setup(config)
  end
}

M.dressing_opts = {
  input = {
    border = ovim_icons.border,
  },
  mappings = {
    n = {
      ["qq"] = "Close",
    },
    i = {
      ["qq"] = "Close",
    },
  }
}

M.lsp_progress_opts = {
  client_format = function(client_name, spinner, series_messages)
    if #series_messages == 0 then
      return nil
    end
    return {
      name = client_name,
      body = spinner .. " " .. table.concat(series_messages, ", "),
    }
  end,
  format = function(client_messages)
    --- @param name string
    --- @param msg string?
    --- @return string
    local function stringify(name, msg)
      return msg and string.format("%s %s", name, msg) or name
    end

    local sign = "" -- nf-fa-gear \uf013
    local lsp_clients = vim.lsp.get_active_clients()
    local messages_map = {}
    for _, climsg in ipairs(client_messages) do
      messages_map[climsg.name] = climsg.body
    end

    if #lsp_clients > 0 then
      table.sort(lsp_clients, function(a, b)
        return a.name < b.name
      end)
      local builder = {}
      for _, cli in ipairs(lsp_clients) do
        if
            type(cli) == "table"
            and type(cli.name) == "string"
            and string.len(cli.name) > 0
        then
          if messages_map[cli.name] then
            table.insert(builder, stringify(cli.name, messages_map[cli.name]))
          else
            table.insert(builder, stringify(cli.name))
          end
        end
      end
      if #builder > 0 then
        return sign .. " " .. table.concat(builder, ", ")
      end
    end

    return ""
  end,
}

return M

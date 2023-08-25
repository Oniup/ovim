-------------------------- COQ ----------------------------
local coq_settings = {
  auto_start = true,
  display = {
    statusline = {
      helo = false
    },
    ghost_text = {
      enabled = false
    },
    pum = {
      source_context = { "", "" },
      kind_context = { " ", "" }
    },
    icons = {
      mode = "short",
    },
    preview = {
      border = "solid"
    },
    mark_highlight_group = "NormalFloat"
  },
  keymap = {
    jump_to_mark = ""
  }
}

vim.api.nvim_set_var("coq_settings", coq_settings)

require("coq_3p")({
  { src = "nvimlua", short_name = "nLUA", conf_only = false },
})

-------------------------- LSP ----------------------------
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

local lsp_on_attach = function(_, bufnr)
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
end

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_capabilities = require("coq").lsp_ensure_capabilities(lsp_capabilities)
-- lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)

require("hlargs").setup({
  color = "#C19C6C",
})


----------------------- Mason Setup -----------------------
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
  -- Automatically setting the LSP up
  function(server)
    local lspconfig = require("lspconfig")
    local config = {
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities
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


-------------------------- CMP ----------------------------
-- local cmp = require "cmp"
-- cmp.setup({
--   -- Enable LSP snippets
--   snippet = {
--     expand = function(args)
--       require("luasnip").lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ["<C-p>"] = cmp.mapping.select_prev_item(),
--     ["<C-n>"] = cmp.mapping.select_next_item(),
--     -- Add tab support
--     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--     ["<Tab>"] = cmp.mapping.select_next_item(),
--     ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<C-e>"] = cmp.mapping.close(),
--     ["<CR>"] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },
--   -- Installed sources:
--   sources = {
--     { name = "path" },
--     { name = "nvim_lsp" },
--     { name = "nvim_lsp_signature_help" },
--     { name = "nvim_lua" },
--     { name = "luasnip" },
--   },
--   window = {
--     completion = cmp.config.window.bordered(),
--     documentation = cmp.config.window.bordered(),
--   },
--
--   formatting = {
--     fields = { "kind", "abbr", "menu" },
--     format = function(_, item)
--       local kind = {
--         Array = "",
--         Boolean = "",
--         Class = "",
--         Color = "",
--         Constant = "",
--         Constructor = "",
--         Enum = "",
--         EnumMember = "",
--         Event = "",
--         Field = "",
--         File = "",
--         Folder = "",
--         Function = "",
--         Interface = "",
--         Key = "",
--         Keyword = "",
--         Method = "",
--         Module = "",
--         Namespace = "",
--         Null = "󰟢",
--         Number = "",
--         Object = "",
--         Operator = "",
--         Package = "",
--         Property = "",
--         Reference = "",
--         Snippet = "",
--         String = "",
--         Struct = "",
--         Text = "",
--         TypeParameter = "",
--         Unit = "",
--         Value = "",
--         Variable = "",
--       }
--
--       local kind_name = item.kind
--       item.kind = string.format("%s", kind[kind_name]) or "?"
--       item.menu = " (" .. kind_name .. ") "
--       return item
--     end,
--   },
-- })
--
-- cmp.setup.cmdline({ "/", "?" }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "buffer" },
--   },
-- })
--
-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = "path" },
--   }, {
--     { name = "cmdline" },
--   }),
-- })


---------------------- Vim Spector ------------------------
vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

vim.keymap.set("n", "<F5>", "<cmd>call vimspector#Launch()<cr>", { noremap = true })
vim.keymap.set("n", "<F8>", "<cmd>call vimspector#Reset()<cr>", { noremap = true })
vim.keymap.set("n", "<F11>", "<cmd>call vimspector#StepOver()<cr>\")", { noremap = true })
vim.keymap.set("n", "<F10>", "<cmd>call vimspector#StepInto()<cr>\")", { noremap = true })
vim.keymap.set("n", "<F12>", "<cmd>call vimspector#StepOut()<cr>\")", { noremap = true })

vim.keymap.set("n", "<leader>bb", ":call vimspector#ToggleBreakpoint()<cr>")
vim.keymap.set("n", "<leader>bw", ":call vimspector#AddWatch()<cr>")
vim.keymap.set("n", "<leader>be", ":call vimspector#Evaluate()<cr>")

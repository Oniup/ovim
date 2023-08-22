-- Hide semantic highlights for functions
vim.api.nvim_set_hl(0, '@lsp.type.function', {})

-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

local keyset = vim.keymap.set

----------------------- Color scheme -----------------------
vim.cmd([[syntax enable]])
vim.cmd.colorscheme("flame")

-- require("kanagawa").setup({
--   functionStyle = { italic = true },
--   keywordStyle = { italic = false },
--   background = {
--     dark = "dragon"
--   }
-- })
--
-- vim.cmd([[colorscheme kanagawa]])


----------------------- Tree sitter -----------------------
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c", "cpp", "c_sharp", "python", "lua", "vimdoc", "vim", "json", "yaml",
    "rust", "toml"
  },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true },
}


------------------------ Telescope ------------------------
local telescope         = require("telescope")
local telescope_actions = require("telescope.actions")
telescope.setup({
  defaults = {
    border = true,
    mappings = {
      i = { ["qq"] = telescope_actions.close },
      n = { ["qq"] = telescope_actions.close },
    },
    layout_strategy = "horizontal",
    layout_config = {
      height = 40,
      width = 160,
      preview_width = 100,
      prompt_position = "top"
    },
    path_display = {
      shorten = 3,
    },
    sorting_strategy = "ascending",
  }
})

local tel_opts = { noremap = true }
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
keyset("n", "<leader>ff", telescope_builtin.find_files, tel_opts)
keyset("n", "<leader>fg", telescope_builtin.live_grep, tel_opts)
keyset("n", "<leader>fb", telescope_builtin.buffers, tel_opts)
keyset("n", "<leader>fh", telescope_builtin.help_tags, tel_opts)


------------------------- Lua line --------------------------
require("lualine").setup({
  options = {
    component_separators = { right = "", left = "" },
    section_separators = { right = "", left = "" },
  }
})


----------------------- Buffer Line -----------------------
require("bufferline").setup({})


------------------------ Nvim Tree ------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})

keyset("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })


--------------------- Project Manager ---------------------
require("project_nvim").setup({
  manual_mode = true,
})
telescope.load_extension("projects")

vim.api.nvim_create_user_command("OpenProject", function()
  telescope.extensions.projects.projects(telescope_themes.get_dropdown({}))
end, {})


----------------------- Comments --------------------------
require("todo-comments").setup({
  signs = true,
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = "󰀪 ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = "󱪘 ", color = "hint", alt = { "INFO" } },
    TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
})

require("Comment").setup()


-------------------- Toggle Terminal ----------------------
local terminal = require("buffer-term")
terminal.setup()

keyset("t", "jk", "<C-\\><C-n>", { noremap = true })

keyset("n", "<A-i>", function() terminal.toggle("a") end,
  { noremap = true, silent = true })
keyset("t", "<A-i>", function() terminal.toggle("a") end, { noremap = true, silent = true })

local disable_spellcheck_in_terminal = vim.api.nvim_create_augroup("disable_spellcheck_in_terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embedded terminal
  command = "setlocal nospell",
  group = disable_spellcheck_in_terminal,
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

  keyset("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keyset("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keyset("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keyset("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keyset("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keyset("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keyset("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  keyset("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keyset("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keyset("n", "<leader>re", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keyset("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keyset("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
end

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)

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
      "lsp_lang_conf." .. server
    )
    if settings_exist then
      config.settings = server_settings
    end

    lspconfig[server].setup(config)
  end
})


----------------------- Rust Tools ------------------------
local rust_tools = require("rust-tools")
rust_tools.setup({
  tools = {
    inlay_hints = {
      auto = false,
      show_parameter_hints = false,
    }
  },
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      keyset("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      keyset(
        "n", "<leader>cg",
        rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end
  }
})

-- Enables :RustRunnables
require('rust-tools').runnables.runnables()


-------------------------- CMP ----------------------------
local cmp = require "cmp"
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "luasnip" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, item)
      local kind = {
        Array = "",
        Boolean = "",
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Key = "",
        Keyword = "",
        Method = "",
        Module = "",
        Namespace = "",
        Null = "󰟢",
        Number = "",
        Object = "",
        Operator = "",
        Package = "",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
      }

      local kind_name = item.kind
      item.kind = string.format("%s", kind[kind_name]) or "?"
      item.menu = " (" .. kind_name .. ") "
      return item
    end,
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})


---------------------- Vim Spector ------------------------
vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

keyset("n", "<F5>", "<cmd>call vimspector#Launch()<cr>", { noremap = true })
keyset("n", "<F8>", "<cmd>call vimspector#Reset()<cr>", { noremap = true })
keyset("n", "<F11>", "<cmd>call vimspector#StepOver()<cr>\")", { noremap = true })
keyset("n", "<F10>", "<cmd>call vimspector#StepInto()<cr>\")", { noremap = true })
keyset("n", "<F12>", "<cmd>call vimspector#StepOut()<cr>\")", { noremap = true })

keyset("n", "<leader>bb", ":call vimspector#ToggleBreakpoint()<cr>")
keyset("n", "<leader>bw", ":call vimspector#AddWatch()<cr>")
keyset("n", "<leader>be", ":call vimspector#Evaluate()<cr>")

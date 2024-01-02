local M = {}
local icons = require("core.utils").icons

local function has_words_before()
  local unpack = table.unpack or nil
  if unpack then
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match("%s")
        == nil
  end
  return false
end

function M.cmp_get_default_opts()
  local cmp = require("cmp")

  local opts = {
    mapping = {
      ["<TAB>"] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= "prompt" and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ["<S-TAB>"] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= "prompt" and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
    }, {
      { name = "buffer" },
    }),
    window = {
      completion = {
        side_padding = 1,
      },
      documentation = {
        border = icons.border,
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          buffer = "buf",
          nvim_lsp = "lsp",
          path = "path",
          cmdline = "cmd",
        })[entry.source.name]
        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
  }

  return opts
end

M.plugin = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- CMP modules
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    -- Snippets
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")

    local opts = M.cmp_get_default_opts()
    if M.cmp_opts_overrides then
      opts = vim.tbl_deep_extend("force", opts, M.cmp_opts_overrides())
    end

    cmp.setup(opts)

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
  end,
}

return M

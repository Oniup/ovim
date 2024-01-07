local M = {}

local ui = require("core.utils").ui
local cmp = require("cmp")

local function has_words_before()
  local unpack = table.unpack or nil
  if unpack then
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(
      0,
      line - 1,
      line,
      true)[1]:sub(col, col):match("%s") == nil
    end
  return false
end

M.opts = {
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
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
  }),
  window = {
    completion = {
      winhighlight = "Normal:NormalFloat,CursorLine:PmenuSel",
      border = ui.border.type,
    },
    documentation = {
      border = ui.border.type,
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = ui.icons.kind[vim_item.kind]
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
      require("luasnip").lsp_expand(args.body)
    end,
  },
}

function M.setup_callback()
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
  })
end

return M

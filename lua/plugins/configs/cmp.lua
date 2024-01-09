local M = {}

local ui = require("core.utils").ui
local cmp = require("cmp")

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

M.menu_names = {
  nvim_lsp = "LSP",
  nvim_lua = "NVIM LSP",
  cmp_tabnine = "TABNINE",
  codeium = "CODEIUM",
  copilot = "COPILOT",
  buffer = "BUFFER",
  luasnip = "SNIP",
  path = "PATH",
  cmdline = "COMMAND",
  calc = "CALC",
  emoji = "EMOJI",
  treesitter = "TREESITTER",
  crates = "CRATES",
  tmux = "TMUX",
}

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
    { name = "nvim_lua" },
    { name = "cmp_tabnine" },
    { name = "codeium" },
    { name = "copilot" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "path" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "tmux" },
  }),
  window = {
    completion = {
      winhighlight = "Normal:NormalFloat,CursorLine:"
        .. ui.cmp.selected_background_color,
      border = ui.border.type,
    },
    documentation = {
      winhighlight = "Normal:NormalFloat",
      border = ui.border.type,
    },
  },
  formatting = {
    fields = ui.cmp.field_arrangement,
    format = function(entry, item)
      -- Menu UI options
      item.menu = ""
      local menu_ui = ui.cmp.menu
      if menu_ui.source then
        item.menu = (M.menu_names)[entry.source.name] or "unknown src"
        if menu_ui.wrap_source and #menu_ui.wrap_source == 2 then
          item.menu = menu_ui.wrap_source[1]
            .. item.menu
            .. menu_ui.wrap_source[2]
        end
      end
      if menu_ui.kind_text then
        item.menu = item.kind .. " " .. item.menu
      end
      -- Limit width size
      if ui.cmp.fixed_width then
        local content = item.abbr
        local win_width = vim.api.nvim_win_get_width(0)
        local max_content_width = math.floor(win_width * ui.cmp.fixed_width)
          - 10
        if #content > max_content_width then
          item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3)
            .. "..."
        else
          item.abbr = content .. (" "):rep(max_content_width - #content)
        end
      end
      -- Kind Icon
      if ui.cmp.kind == "icon" then
        item.kind = ui.icons.kind[item.kind] or "?"
      elseif ui.cmp.kind == "text" then
        item.kind = item.kind
      else
        item.kind = ""
      end
      return item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
}

function M.loaded_callback()
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
  })
end

return M

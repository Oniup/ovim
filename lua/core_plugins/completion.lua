local M = {}
local icons = require("core.utils").icons

local has_words_before = function()
  local unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

function M.cmp_get_opts()
  local cmp = require("cmp")

  local opts = {
    mapping = cmp.mapping.preset.insert({
      ["<TAB>"] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
      ["<S-TAB>"] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
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
    }),
    sources = cmp.config.sources(
      {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
      },
      {
        { name = "buffer" },
        { name = "path" }
      }
    ),
    window = {
      completion = {
        col_offset = -3,
        side_padding = 0,
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
      end
    },
    snippet = {
      expand = function(args)
        unpack = unpack or table.unpack
        local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
        local indent = string.match(line_text, '^%s*')
        local replace = vim.split(args.body, '\n', true)
        local surround = string.match(line_text, '%S.*') or ''
        local surround_end = surround:sub(col)

        replace[1] = surround:sub(0, col - 1) .. replace[1]
        replace[#replace] = replace[#replace] .. (#surround_end > 1 and ' ' or '') .. surround_end
        if indent ~= '' then
          for i, line in ipairs(replace) do
            replace[i] = indent .. line
          end
        end

        vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
      end
    },
  }

  return opts
end

M.plugin = {
  "hrsh7th/nvim-cmp",
  -- Completion modules supported
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "rcarriga/cmp-dap",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup(M.cmp_get_opts())

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        {
          { name = "path" }
        },
        {
          { name = "cmdline" }
        }
      ),
    })

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })
  end
}

return M

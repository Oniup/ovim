return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "f3fora/cmp-spell",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local lsp_kind = {
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

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<TAB>"] = cmp.mapping.select_next_item(),   -- next suggestion
        ["<S-TAB>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-b>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "spell",   option = { keep_all_entries = false } },
        { name = "buffer" },
      }),
      window = {
        completion = cmp.config.window.bordered({
          border = "single"
        }),
        documentation = cmp.config.window.bordered({
          border = "single"
        }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        -- fields = { "kind", "abbr" },
        format = function(_, item)
          local kind_name = item.kind
          item.kind = string.format("%s", lsp_kind[kind_name] or "?")
          item.menu = "" .. kind_name .. ""
          return item
        end,
      },
      view = {
        docs = { auto_open = true }
      },
    })
  end,
}

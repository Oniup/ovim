return {
  icons = require("core.icons"),
  border = {
    type = "rounded",
    telescope = {
      single = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      double = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
      rounded = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      solid = { " ", " ", " ", " ", " ", " ", " ", " " },
      shadow = { " ", "░", "░", " ", " ", " ", "░", " " },
      none = {},
    },
  },
  cmp = {
    formatting = {
      fields = { "kind", "abbr", "menu" },
    },
  },
  lspconfig = {},
  colorscheme = {
    theme = "ignite",
    hl_overrides = {},
  },
  disable_ui_module = {}, -- lspconfig | bufferline | etc...
}

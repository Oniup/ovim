return {
  icons = require("core.icons"),
  border = {
    type = "rounded",
    telescope_borderchars = {
      single = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      double = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
      rounded = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      solid = { " ", " ", " ", " ", " ", " ", " ", " " },
      none = {},
    },
  },
  cmp = {
    formatting = {
      fields = { "kind", "abbr", "menu" },
    },
  },
  colorscheme = {
    theme = "ignite",
    hl_overrides = {},
  },
  disable_ui_module = {}, -- lsp | bufferline | etc...
}

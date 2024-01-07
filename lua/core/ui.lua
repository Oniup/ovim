local u = require("core.utils")

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
    }
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
  load_ui_module = {
    "core.ui.lsp",
    "core.ui.bufferline",
    "core.ui.cmp",
  },
}

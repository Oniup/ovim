return {
  icons = require("core.icons"),
  border = {
    type = "rounded",
    telescope = {
      single = {
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      double = {
        prompt = { "═", "║", " ", "║", "╔", "╗", "║", "║" },
        results = { "═", "║", "═", "║", "╠", "╣", "╝", "╚" },
        preview = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
      },
      rounded = {
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      shadow = {
        prompt = { " ", "░", " ", " ", " ", " ", "░", " " },
        results = { " ", "░", "░", " ", " ", "░", "░", " " },
        preview = { " ", "░", "░", " ", " ", "░", "░", " " },
      },
      solid = { " ", " ", " ", " ", " ", " ", " ", " " },
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

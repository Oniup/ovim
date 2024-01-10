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
    menu = {
      source = true,
      wrap_source = { "(", ")" },
      kind_text = true,
    },
    kind = "icon", -- "none", "icon", "text"
    field_arrangement = { "kind", "abbr", "menu" },
    selected_background_color = "PmenuSel",
    fixed_width = 0.4,
    background = {
      color = "darker",
    },
  },
  lspconfig = {
    virtual_text = true,
  },
  colorscheme = {
    theme = "ignite",
    hl_overrides = {},
  },
}

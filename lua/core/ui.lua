local M = {}

M.colorscheme = {
  theme = "ignite",
  hl_overrides = {},
}

M.icons = require("core.icons")

M.border = {
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
}

M.cmp = {
  menu = {
    source = true,
    kind = false,
    wrap = { "", "" },
  },
  kind = {
    icon = true,
    name = true,
    wrap_name = { "(", ")" },
  },
  field_arrangement = { "abbr", "kind", "menu" },
  selected_background_color = "PmenuSel",
  fixed_width = 0.4,
  background = {
    color = "darker",
  },
}

M.lsp = {
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    border = M.border.type,
    source = "always",
    header = "",
    prefix = "",
  },
}

M.dapui = {
  controls = {
    element = "console",
    enabled = true,
    icons = M.icons.dapui.debugging_controls,
  },
  layouts = {
    {
      size = 40,
      position = "left",
      elements = {
        { id = "scopes", size = 0.50 },
        { id = "watches", size = 0.25 },
        { id = "stacks", size = 0.25 },
      },
    },
    {
      size = 10,
      position = "bottom",
      elements = {
        { id = "console", size = 1.0 },
      },
    },
  },
}

return M

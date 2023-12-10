return {
  border = "single", -- Options: :h nvim_open_win
  border_chars = {
    single = {
      prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    rounded = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    none = {}
  },
  mason = {
    package_installed = "",
    package_pending = "",
    package_uninstalled = "",
  },
  diagnostics = {
    error = " ",
    warn  = " ",
    info  = " ",
    hint  = " ",
    other = {
      todo = " ",
      warn = "󰀪 ",
      hack = " ",
      note = "󱪘 ",
      perf = " ",
      test = " "
    },
  },
  gitsigns = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '│' },
    untracked    = { text = '│' },
  },
  kind = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰘧",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = " ",
    Unknown = " ",
  }
}

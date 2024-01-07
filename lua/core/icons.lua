local M = {}

M.mason = {
  package_installed = "",
  package_pending = "",
  package_uninstalled = " 󰚌",
}

M.lazy = {
  cmd = " ",
  config = "",
  event = "",
  ft = "󰈙 ",
  init = " ",
  import = " ",
  keys = "󰌌 ",
  lazy = "󰂠 ",
  loaded = "",
  not_loaded = "",
  plugin = " ",
  runtime = " ",
  require = "󰢱 ",
  source = "󰅱 ",
  start = "",
  task = "",
  list = { "●", "➜", "★", "‒" },
}

M.diagnostics = {
  error = " ",
  warn = " ",
  info = " ",
  hint = " ",
  other = {
    todo = " ",
    warn = "󰀪 ",
    hack = " ",
    note = "󱪘 ",
    perf = " ",
    test = " ",
  },
}

M.gitsigns = {
  add = { text = "│" },
  change = { text = "│" },
  delete = { text = "_" },
  topdelete = { text = "‾" },
  changedelete = { text = "│" },
  untracked = { text = "│" },
}

M.nvim_tree_glyphs = {
  default = "󰈙",
  symlink = "",
  bookmark = "",
  folder = {
    arrow_closed = "",
    arrow_open = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "",
    deleted = "󱂥",
    ignored = "",
  },
}

M.whichkey = {
  breadcrumb = "»",
  separator = "➜",
  group = "",
}

M.kind = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "󰕳",
  Property = "",
  Unit = "󰑭",
  Value = "",
  Enum = "",
  EnumMember = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
  Parameter = "󰘦",
  Unknown = "",
  Number = "",
  Boolean = "󰨚",
  Character = "󱌯",
  String = "󰅳",
  Codeium = "󰚩",
}

return M

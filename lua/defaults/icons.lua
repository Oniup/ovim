local M = {}

M.common = {
  list = {
    pending = "",
    enabled = "",
    disabled = "",
    bullet = "●",
    bullet_disabled = "○",
    arrow = "➜",
    star = "★",
    dash = "‒",
  },
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
  files = {
    default = "󰈙",
    symlink = "",
    bookmark = " "
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

M.border = "solid" -- Options: :h nvim_open_win
M.border_chars = {
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
  solid = {
    prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
    results = { " ", " ", " ", " ", " ", " ", " ", " " },
    preview = { " ", " ", " ", " ", " ", " ", " ", " " },
  },
  none = {}
}

M.mason = {
  package_installed = M.common.list.enabled,
  package_pending = M.common.list.pending,
  package_uninstalled = M.common.list.enabled,
}

M.lazy = {
  cmd = " ",
  config = "",
  event = "",
  ft = "󰈙 ",
  init = " ",
  import = " ",
  keys = "󰌌 ",
  lazy = "󰒲 ",
  loaded = M.common.list.enabled,
  not_loaded = M.common.list.disabled,
  plugin = " ",
  runtime = " ",
  require = "󰢱 ",
  source = "󰅱 ",
  start = "",
  task = M.common.list.enabled,
  list = {
    M.common.list.bullet,
    M.common.list.arrow,
    M.common.list.star,
    M.common.list.dash,
  },
}

M.diagnostics = {
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
}

M.gitsigns = {
  add          = { text = '│' },
  change       = { text = '│' },
  delete       = { text = '_' },
  topdelete    = { text = '‾' },
  changedelete = { text = '│' },
  untracked    = { text = '│' },
}

M.nvim_tree_glyphs = {
  default = M.common.files.default,
  symlink = M.common.files.symlink,
  bookmark = M.common.files.bookmark,
  folder = M.common.folder,
  git = M.common.git,
}

M.kind = {
  Text = "󰉿 ",
  Method = "󰆧 ",
  Function = "󰆧 ",
  Constructor = " ",
  Field = " ",
  Variable = "󰀫 ",
  Class = "󰠱 ",
  Interface = " ",
  Module = "󰕳 ",
  Property = " ",
  Unit = "󰑭 ",
  Value = " ",
  Enum = " ",
  EnumMember = " ",
  Keyword = "󰌋 ",
  Snippet = " ",
  Color = "󰏘 ",
  File = M.common.files.default .. " ",
  Reference = M.common.files.symlink .. " ",
  Folder = M.common.folder.default .. " ",
  Constant = "󰏿 ",
  Struct = " ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = " ",
  Parameter = "󰘦 ",
  Unknown = "  ",
  Number = " ",
  Boolean = "󰨚  ",
  Character = "󱌯 ",
  String = "󰅳 ",
}

return M

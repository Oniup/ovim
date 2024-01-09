local M = {}

M.mason = {
  package_installed = "",
  package_pending = "",
  package_uninstalled = "",
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
  default = "󰈚",
  symlink = "",
  bookmark = "",
  folder = {
    arrow_closed = "",
    arrow_open = "",
    default = "",
    empty = "",
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = "",
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
  Variable = "",
  Class = "󰠱",
  Interface = "",
  Module = "󰕳",
  Property = "",
  Unit = "󰑭",
  Value = "",
  Enum = "",
  EnumMember = "",
  Keyword = "󰌆",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
  Parameter = "󰘦",
  Unknown = "?",
  Number = "",
  Boolean = "󰨚",
  Character = "󱌯",
  String = "",
  Codeium = "󰚩",
  Copilot = "",
}

M.devicons = {
  default_icon = { icon = "󰈚", name = "Default" },
  c = { icon = "", name = "c" },
  css = { icon = "", name = "css" },
  dart = { icon = "", name = "dart" },
  deb = { icon = "", name = "deb" },
  Dockerfile = { icon = "", name = "Dockerfile" },
  html = { icon = "", name = "html" },
  jpeg = { icon = "󰉏", name = "jpeg" },
  jpg = { icon = "󰉏", name = "jpg" },
  js = { icon = "󰌞", name = "js" },
  kt = { icon = "󱈙", name = "kt" },
  lock = { icon = "󰌾", name = "lock" },
  lua = { icon = "", name = "lua" },
  mp3 = { icon = "󰎆", name = "mp3" },
  mp4 = { icon = "", name = "mp4" },
  out = { icon = "", name = "out" },
  png = { icon = "󰉏", name = "png" },
  py = { icon = "", name = "py" },
  ["robots.txt"] = { icon = "󰚩", name = "robots" },
  toml = { icon = "", name = "toml" },
  ts = { icon = "󰛦", name = "ts" },
  ttf = { icon = "", name = "TrueTypeFont" },
  rb = { icon = "", name = "rb" },
  rpm = { icon = "", name = "rpm" },
  vue = { icon = "󰡄", name = "vue" },
  woff = { icon = "", name = "WebOpenFontFormat" },
  woff2 = { icon = "", name = "WebOpenFontFormat2" },
  xz = { icon = "", name = "xz" },
  zip = { icon = "", name = "zip" },
}

return M

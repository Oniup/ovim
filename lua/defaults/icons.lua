return {
  border = "single",
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
    other  = {
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
}

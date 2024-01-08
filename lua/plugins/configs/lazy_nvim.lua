local u = require("core.utils")

return {
  defaults = {
    lazy = true,
    version = "*",
  },
  install = {
    missing = true,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = u.ui.border.type,
    size = { width = 0.6, height = 0.6 },
    icons = u.ui.icons.lazy,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

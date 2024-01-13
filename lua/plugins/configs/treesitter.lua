local M = {}

M.opts = {
  ensure_installed = {
    "lua",
    "vimdoc",
    "vim",
    "markdown",
    "markdown_inline",
  },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
  indent = {
    enable = true,
  },
}

return M

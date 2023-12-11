local M = {}

M.name = "nvim-treesitter.configs"

M.info = {
  "nvim-treesitter/nvim-treesitter",
  buld = ":TSUpdate",
  event = "BufEnter",
}

M.opts = {
  ensure_installed = { "lua", "vimdoc", "vim", "json", "yaml", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true },
}

return M

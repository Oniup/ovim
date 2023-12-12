local M = {}

M.opts = {
  "nvim-treesitter/nvim-treesitter",
  buld = ":TSUpdate",
  event = "BufEnter",
  opts = {
    ensure_installed = { "lua", "vimdoc", "vim", "json", "yaml", "toml" },
    auto_install = true,
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
  },
  config = function()
    require("nvim-treesitter.configs").setup(M.opts.opts)
  end
}

return M

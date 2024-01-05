local M = {}

M.plugin = {
  "nvim-treesitter/nvim-treesitter",
  buld = ":TSUpdate",
  event = "BufEnter",
  opts = {
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
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return M

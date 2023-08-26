return {
  "nvim-treesitter/nvim-treesitter",
  buld = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "c_sharp", "python", "lua", "vimdoc", "vim", "json", "yaml",
        "rust", "toml"
      },
      auto_install = false,
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
    })
  end
}

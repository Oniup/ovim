return {
  "nvim-treesitter/nvim-treesitter",
  buld = ":TSUpdate",
  event = "BufEnter",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "c_sharp", "python", "lua", "vimdoc", "vim", "json", "yaml",
        "toml", "make", "glsl", "html"
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

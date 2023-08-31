return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        theme = require("ignite.lualine"),
        component_separators = { right = "", left = "" },
        section_separators = { right = "", left = "" },
      },
      extensions = {
        "nvim-tree",
        "lazy",
      },
    })
  end,
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        component_separators = { right = "", left = "" },
        section_separators = { right = "", left = "" },
      },
    })
  end,
}

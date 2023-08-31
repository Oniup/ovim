return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            text_align = "left",
            separator = false,
            highlight = "Title",
          },
        },
        separator_style = "thin",
      },
    })
  end
}

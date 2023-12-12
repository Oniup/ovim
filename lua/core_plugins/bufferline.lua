local M = {}

M.opts = {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufEnter",
  opts = {
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
  },
}

return M

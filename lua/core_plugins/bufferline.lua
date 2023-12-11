local M = {}

M.name = "bufferline"

M.info = {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufEnter",
}

M.opts = {
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
}

return M

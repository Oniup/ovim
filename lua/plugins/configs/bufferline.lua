local M = {}

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

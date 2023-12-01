local filename = {
  "filename",
  file_status = false,
  newfile_status = false,
  path = 0,
  symbols = {
    modified = "",
    readonly = "READ ONLY",
    unnamed = "",
    newfile = "",
  },
}

local filetype = {
  "filetype",
  colored = false,
  icon_only = true,
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "Exafunction/codeium.vim",
  },
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        theme = require("ignite.lualine"),
        component_separators = { right = "", left = "" },
        section_separators = { right = "", left = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "diff" },
        lualine_x = { "codeium#GetStatusString", "diagnostics" },
        lualine_y = { filename },
        lualine_z = { filetype, "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "diff" },
        lualine_x = { "diagnostics" },
        lualine_y = { filename },
        lualine_z = {},
      },
      extensions = {
        "nvim-tree",
        "lazy",
        "nvim-dap-ui",
      },
    })
  end,
}

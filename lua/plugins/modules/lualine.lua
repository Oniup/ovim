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
    "linrongbin16/lsp-progress.nvim",
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
        lualine_c = { require("lsp-progress").progress, "diff", },
        lualine_x = { "diagnostics", "codeium#GetStatusString" },
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

    vim.api.nvim_create_augroup("lualine_group", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_group",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end,
}

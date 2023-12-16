local M = {}
local icons = require("core.utils").icons

M.sections = {
  mode = "mode",
  diff = {
    "diff",
    symbols = {
      added = icons.common.git.untracked .. " ",
      modified = icons.common.git.renamed .. " ",
      removed = icons.common.git.deleted .. " ",
    },
  },
  branch = "branch",
  location = "location",
  lsp_progress = { function() return require("lsp-progress").progress() end },
  progress = "progress",
  filename = {
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
  },
  filetype = {
    "filetype",
    colored = false,
    icon_only = true,
  },
  diagnostics = {
    "diagnostics",
    diagnostics_color = {
      diagnostics_color = {
        error = 'DiagnosticError',
        warn  = 'DiagnosticWarn',
        info  = 'DiagnosticInfo',
        hint  = 'DiagnosticHint',
      },
      colored = true,
      update_in_insert = true,
      always_visable = true,
    },
    symbols = {
      error = icons.diagnostics.error,
      warn = icons.diagnostics.warn,
      info = icons.diagnostics.info,
      hint = icons.diagnostics.hint,
    },
  }
}

M.plugin = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "linrongbin16/lsp-progress.nvim",
  },
  event = "BufEnter",
  opts = {
    options = {
      theme = function() return require("ignite.lualine_theme") end,
      component_separators = { right = "", left = "" },
      section_separators = { right = "", left = "" },
    },
    sections = {
      lualine_a = { M.sections.mode },
      lualine_b = { M.sections.branch, M.sections.diff },
      lualine_c = { M.sections.diagnostics },
      lualine_x = {},
      lualine_y = { M.sections.lsp_progress, },
      lualine_z = { M.sections.filetype, M.sections.progress, M.sections.location },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { M.sections.diff },
      lualine_c = { M.sections.diagnostics },
      lualine_x = {},
      lualine_y = { M.sections.filename, M.sections.location },
      lualine_z = {},
    },
    extensions = {
      "lazy",
      "mason",
      "nvim-tree",
      "nvim-dap-ui",
    }
  },
  config = function(_, opts)
    require("lualine").setup(opts)

    vim.api.nvim_create_augroup("lualine_group", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_group",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end,
}

return M

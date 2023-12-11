local M = {}

M.name = "lualine"

M.info = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",

    -- "Exafunction/codeium.vim",
    "linrongbin16/lsp-progress.nvim",
  },
  event = "BufEnter",
}

M.sections = {
  mode = "mode",
  diff = "diff",
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
    sections = { "error", "warn", "info", "hint" },
    diagnostics_color = {
      diagnostics_color = {
        error = 'DiagnosticError',
        warn  = 'DiagnosticWarn',
        info  = 'DiagnosticInfo',
        hint  = 'DiagnosticHint',
      },
      symbols = require("core.utils").icons.diagnostics,
      colored = true,
      update_in_insert = true,
      always_visable = true,
    }
  }
}

M.opts = {
  options = {
    theme = function() return require("ignite.lualine") end,
    component_separators = { right = "", left = "" },
    section_separators = { right = "", left = "" },
  },
  sections = {
    lualine_a = { M.sections.mode },
    lualine_b = { M.sections.branch, M.sections.diff },
    lualine_c = { M.sections.diagnostics },
    -- lualine_x = { "codeium#GetStatusString" },
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
    "nvim-tree",
    "lazy",
    "nvim-dap-ui",
  }
}

M.after_setup = function()
  vim.api.nvim_create_augroup("lualine_group", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = "lualine_group",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
  })
end

return M

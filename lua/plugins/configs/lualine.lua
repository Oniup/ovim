local M = {}

local ui = require("core.utils").ui

vim.opt.laststatus = 2

M.sections = {
  mode = "mode",
  diff = {
    "diff",
    symbols = {
      added = ui.icons.nvim_tree_glyphs.git.untracked .. " ",
      modified = ui.icons.nvim_tree_glyphs.git.renamed .. " ",
      removed = ui.icons.nvim_tree_glyphs.git.deleted .. " ",
    },
  },
  branch = "branch",
  location = "location",
  lsp_progress = {
    require("lsp-progress").progress,
  },
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
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
      },
      colored = true,
      update_in_insert = true,
      always_visable = true,
    },
    symbols = {
      error = ui.icons.diagnostics.error,
      warn = ui.icons.diagnostics.warn,
      info = ui.icons.diagnostics.info,
      hint = ui.icons.diagnostics.hint,
    },
  },
}

M.opts = {
  options = {
    theme = function()
      return require("ignite.lualine_theme")
    end,
    component_separators = { right = "", left = "" },
    section_separators = { right = "", left = "" },
  },
  sections = {
    lualine_a = { M.sections.mode },
    lualine_b = { M.sections.branch, M.sections.diff },
    lualine_c = { M.sections.diagnostics },
    lualine_x = {},
    lualine_y = { M.sections.lsp_progress },
    lualine_z = {
      M.sections.filetype,
      M.sections.progress,
      M.sections.location,
    },
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
    "nvim-dap-ui",
    -- "lazy",
    -- "mason",
    "nvim-tree",
    "toggleterm",
  },
}

function M.loaded_callback()
  vim.api.nvim_create_augroup("lualine_group", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = "lualine_group",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
  })
end

return M

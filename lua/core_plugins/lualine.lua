return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",

    -- "Exafunction/codeium.vim",
    "linrongbin16/lsp-progress.nvim",
  },
  event = "BufEnter",
  config = function()
    local sections = {
      mode = "mode",
      diff = "diff",
      branch = "branch",
      location = "location",
      lsp_progress = { require("lsp-progress").progress },
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

    require("lualine").setup({
      options = {
        theme = require("ignite.lualine"),
        component_separators = { right = "", left = "" },
        section_separators = { right = "", left = "" },
      },
      sections = {
        lualine_a = { sections.mode },
        lualine_b = { sections.branch, sections.diff },
        lualine_c = { sections.diagnostics },
        -- lualine_x = { "codeium#GetStatusString" },
        lualine_x = {},
        lualine_y = { sections.lsp_progress, },
        lualine_z = { sections.filetype, sections.progress, sections.location },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { sections.diff },
        lualine_c = { sections.diagnostics },
        lualine_x = {},
        lualine_y = { sections.filename, sections.location },
        lualine_z = {},
      },
      extensions = {
        "nvim-tree",
        "lazy",
        "nvim-dap-ui",
      }
    })

    vim.api.nvim_create_augroup("lualine_group", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_group",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
  end,
}

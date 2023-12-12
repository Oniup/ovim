local M = {}
local icons = require("defaults.icons")

M.opts = {
  "folke/todo-comments.nvim",
  lazy = false,
  opts = {
    signs = true,
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = icons.diagnostics.other.todo, color = "info" },
      HACK = { icon = icons.diagnostics.other.hack, color = "warning" },
      WARN = { icon = icons.diagnostics.other.warn, color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = icons.diagnostics.other.perf, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = icons.diagnostics.other.note, color = "hint", alt = { "INFO" } },
      TEST = { icon = icons.diagnostics.other.test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    }
  }
}

return M

local M = {}

function M.correct_border()
  local border = require("core.utils").icons.border
  if border == "solid" then
    return {
      NormalFloat = { link = "NoBorderNormalFloat" },
      FloatTitle = { link = "NoBorderFloatTitle" },
      FloatBorder = { link = "Background2" },

      TelescopeNormal = { link = "NormalFloat" },
      TelescopePromptNormal = { link = "NormalFloat" },
      TelescopeBorder = { link = "FloatBorder" },
      TelescopePromptBorder = { link = "FloatBorder" },
      TelescopePromptTitle = { link = "NoBorderFloatTitle" },
      TelescopePreviewTitle = { link = "NoBorderFloatTitle" },
      TelescopeResultsTitle = { link = "NoBorderFloatTitle" },
    }
  end
  return {}
end

M.plugin = {
  "Oniup/ignite.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    colors = {
      groups = M.correct_border(),
    },
  },
  config = function(_, opts)
    -- TODO: Allow to change colorscheme
    require("ignite").setup(opts)
    vim.cmd.colorscheme("ignite")
  end,
}

return M

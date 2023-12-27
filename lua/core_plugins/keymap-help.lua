local M = {}
local icons = require("core.utils").icons

M.plugin = {
  "folke/which-key.nvim",
  lazy = false,
  opts = {
    -- plugins = {
    --   operators = { gc = "Comments" },
    --   key_labels = {
    --     -- override the label used to display some keys. It doesn't effect WK in any other way.
    --     -- For example:
    --     -- ["<space>"] = "SPC",
    --     -- ["<cr>"] = "RET",
    --     -- ["<tab>"] = "TAB",
    --   },
    --   motions = {
    --     count = true,
    --   },
    --   icons = icons.whichkey,
    --   popup_mappings = {
    --     scroll_down = "<c-d>", -- binding to scroll down inside the popup
    --     scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    --   },
    --   window = {
    --     border = function()
    --       if icons.border == "solid" then
    --         return "none"
    --       end
    --       return icons.border
    --     end,                 -- none, single, double, shadow
    --     position = "bottom", -- bottom, top
    --     margin = { 1, 0, 1, 0 },
    --     padding = { 1, 2, 1, 2 },
    --     zindex = 1000,        -- makes sure to be in front of all other windows
    --   },
    --   ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    --   triggers_blacklist = {
    --     i = { "j", "k" },
    --     v = { "j", "k" },
    --   },
    -- },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
}

return M

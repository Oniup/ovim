local M = {}

local icons = require("core.utils").icons

local function telescope_actions()
  return require("telescope.actions")
end

local search_with_preview = {
  preview = true,
  results_title = false,
  layout_strategy = "vertical",
  layout_config = {
    anchor = "N",
    width = 0.5,
    height = 0.6,
    preview_height = 0.6,
    prompt_position = "top"
  }
}

M.plugin = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    -- Extensions
    "BurntSushi/ripgrep",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["qq"] = function(buf) telescope_actions().close(buf) end,
          ["<c-l>"] = function(buf) telescope_actions().select_vertical(buf) end,
          ["<c-j>"] = function(buf) telescope_actions().select_horizontal(buf) end
        },
        n = {
          ["qq"] = function(buf) telescope_actions().close(buf) end,
          ["<c-l>"] = function(buf) telescope_actions().select_vertical(buf) end,
          ["<c-j>"] = function(buf) telescope_actions().select_horizontal(buf) end
        },
      },
      border = true,
      borderchars = icons.border_chars[icons.border],
      sorting_strategy = "ascending",
      preview = false,
      results_title = false,
      layout_strategy = "horizontal",
      layout_config = {
        anchor = "N",
        width = 0.4,
        height = 0.3,
        prompt_position = "top"
      },
    },
    pickers = {
      live_grep = search_with_preview,
      help_tags = search_with_preview,
      current_buffer_fuzzy_find = search_with_preview,
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    telescope.load_extension("ui-select")
  end,
}

return M

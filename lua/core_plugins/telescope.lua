local M = {}

local icons = require("core.utils").icons

local function telescope_actions()
  return require("telescope.actions")
end

local enable_preview = {
  preview = true,
  layout_config = {
    width = 0.8,
    preview_width = 0.5,
  }
}

M.plugin = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    -- Extensions
    "BurntSushi/ripgrep",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build =
      "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
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
        prompt_position = "top",
        anchor = "N",
        width = 0.4,
        height = 0.5,
      },
    },
    pickers = {
      current_buffer_fuzzy_find = enable_preview,
      live_grep = enable_preview,
      help_tags = enable_preview,
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}

return M

local M = {}

local icons = require("core.utils").icons

local horizontal_layout = {
  preview = true,
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.7,
    height = 0.6,
    preview_width = 0.65,
  },
}

M.telescope = function()
  return require("telescope")
end

M.telescope_actions = function()
  return require("telescope.actions")
end

M.plugin = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    -- Extensions
    "BurntSushi/ripgrep",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build " ..
          "build --config Release && cmake --install build --prefix build"
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  event = "BufEnter",
  opts = {
    defaults = {
      preview = false,
      mappings = {
        i = {
          ["qq"] = function(buf) M.telescope_actions().close(buf) end,
          ["<c-l>"] = function(buf) M.telescope_actions().select_vertical(buf) end,
          ["<c-j>"] = function(buf) M.telescope_actions().select_horizontal(buf) end
        },
        n = {
          ["qq"] = function(buf) M.telescope_actions().close(buf) end,
          ["<c-l>"] = function(buf) M.telescope_actions().select_vertical(buf) end,
          ["<c-j>"] = function(buf) M.telescope_actions().select_horizontal(buf) end
        },
      },
      border = true,
      borderchars = icons.border_chars[icons.border],
      results_title = false,
      layout_strategy = "center",
      layout_config = {
        width = 0.5,
        height = 0.5,
        prompt_position = "top"
      },
      sorting_strategy = "ascending",
    },
    pickers = {
      help_tags = horizontal_layout,
      live_grep = horizontal_layout,
      media_files = horizontal_layout,
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    }
  },
  init = function()
    M.telescope().load_extension("fzf")
    M.telescope().load_extension("file_browser")
    M.telescope().load_extension("ui-select")
  end
}

return M

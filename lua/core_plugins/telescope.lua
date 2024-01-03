local M = {}

local icons = require("core.utils").icons

local function telescope_actions()
  return require("telescope.actions")
end

local enable_preview = {
  preview = true,
  layout_config = {
    width = 0.80,
    preview_width = 0.50,
  },
}

local function get_correct_border_chars()
  if type(icons.border) == "table" then
    return {
      icons.border[2],
      icons.border[4],
      icons.border[6],
      icons.border[8],
      icons.border[1],
      icons.border[3],
      icons.border[5],
      icons.border[7],
    }
  end
  return icons.border_chars[icons.border]
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
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      initial_mode = "insert",
      selection_strategy = "reset",
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      border = true,
      borderchars = get_correct_border_chars(),
      sorting_strategy = "ascending",
      preview = false,
      results_title = false,
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        anchor = "N",
        width = 0.40,
        height = 0.50,
      },
      -- file_sorter = function() return require("telescope.sorters").get_fuzzy_file end,
      file_ignore_patterns = { "node_modules" },
      -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      mappings = {
        i = {
          ["qq"] = function(buf)
            telescope_actions().close(buf)
          end,
          ["<c-l>"] = function(buf)
            telescope_actions().select_vertical(buf)
          end,
          ["<c-j>"] = function(buf)
            telescope_actions().select_horizontal(buf)
          end,
        },
        n = {
          ["qq"] = function(buf)
            telescope_actions().close(buf)
          end,
          ["<c-l>"] = function(buf)
            telescope_actions().select_vertical(buf)
          end,
          ["<c-j>"] = function(buf)
            telescope_actions().select_horizontal(buf)
          end,
        },
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

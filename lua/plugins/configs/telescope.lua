local M = {}

local ui = require("core.utils").ui
local actions = require("telescope.actions")

M.enable_preview = {
  preview = true,
  layout_config = {
    width = 0.80,
    preview_width = 0.50,
  },
}

M.extension_list = {
  "fzf",
  "ui-select",
}

M.opts = {
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
    border = ui.border.type ~= "none",
    borderchars = ui.border.telescope[ui.border.type],
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
    file_sorter = function() return require("telescope.sorters").get_fuzzy_file end,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    file_ignore_patterns = { "node_modules", ".git", ".cache" },
    path_display = { "truncate" },
    mappings = {
      i = {
        ["q"] = actions.close,
        ["<C-l>"] = actions.select_vertical,
        ["<C-j>"] = actions.select_horizontal,
      },
      n = {
        ["q"] = actions.close,
        ["<C-l>"] = actions.select_vertical,
        ["<C-j>"] = actions.select_horizontal,
      },
    },
  },
  pickers = {
    current_buffer_fuzzy_find = M.enable_preview,
    live_grep = M.enable_preview,
    help_tags = M.enable_preview,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

function M.setup_callback(config)
  for _, ext in ipairs(config.extension_list) do
    require("telescope").load_extension(ext)
  end
end

return M

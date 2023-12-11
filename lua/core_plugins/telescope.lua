local horizontal_layout = {
  preview = true,
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.7,
    height = 0.6,
    preview_width = 0.65,
  },
}

local M = {}

M.name = "telescope"

M.determin_border_chars = function()
  local icons = require("core.utils").icons
  if icons.border == "single" then
    return icons.border_chars.single
  elseif icons.border == "rounded" then
    return icons.border_chars.rounded
  end
  return {}
end

M.info = {
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
}

M.opts = {
  defaults = {
    preview = false,
    mappings = {
      i = {
        ["qq"] = function(buf) require("telescope.actions").close(buf) end,
        ["<c-l>"] = function() require("telescope.actions").select_vertical() end,
        ["<c-j>"] = function() require("telescope.actions").select_horizontal() end
      },
      n = {
        ["qq"] = function(buf) require("telescope.actions").close(buf) end,
        ["<c-l>"] = function() require("telescope.actions").select_vertical() end,
        ["<c-j>"] = function() require("telescope.actions").select_horizontal() end
      },
    },
    border = true,
    borderchars = M.determin_border_chars(),
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
}

M.after_setup = function()
  local telescope = require("telescope")
  telescope.load_extension("fzf")
  telescope.load_extension("file_browser")
  telescope.load_extension("ui-select")
end

return M

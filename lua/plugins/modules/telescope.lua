return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Extensions
    "BurntSushi/ripgrep",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build " ..
          "build --config Release && cmake --install build --prefix build"
    },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  branch = "0.1.2",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, mode = "n" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  mode = "n" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end,  mode = "n" },
    { "<leader>fb", mode = "n" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["qq"] = actions.close,
            ["<C-l>"] = actions.select_vertical,
            ["<C-j>"] = actions.select_horizontal
          },
          n = {
            ["qq"] = actions.close,
            ["<C-l>"] = actions.select_vertical,
            ["<C-j>"] = actions.select_horizontal
          },
        },

        -- Theme
        border = true,
        borderchars = {
          prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
          preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        layout_strategy = "vertical",
        layout_config = {
          width = 0.5,
          height = 0.5,
          prompt_position = "top"
        },
        sorting_strategy = "ascending",
      },

      pickers = {
        help_tags = {
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.7,
            height = 0.6,
            preview_width = 0.65,
          }
        },
        find_files = {
          previewer = false,
        },
        live_grep = {
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.7,
            height = 0.6,
            preview_width = 0.65,
          },
        },
      },

      extensions = {
        file_browser = {
          previewer = false,
        },
        project = {
          layout_strategy = "bottom",
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")

    local opts = { noremap = true, silent = true }
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

    vim.keymap.set("n", "<leader>fb", function()
      require "telescope".extensions.file_browser.file_browser {}
    end, opts)
  end,
}

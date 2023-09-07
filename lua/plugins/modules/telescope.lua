local horizontal_layout = {
  preview = true,
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.7,
    height = 0.6,
    preview_width = 0.65,
  },
}

return {
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
        preview = false,
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
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")

    local opts = { noremap = true, silent = true }
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

    -- Configuration/Modules/Vim
    vim.keymap.set("n", "<leader>vo", builtin.vim_options, opts)
    vim.keymap.set("n", "<leader>vc", builtin.commands, opts)
    vim.keymap.set("n", "<leader>vm", builtin.reloader, opts)

    vim.keymap.set("n", "z=", builtin.spell_suggest, opts)

    vim.keymap.set("n", "<leader>fb", function()
      telescope.extensions.file_browser.file_browser({})
    end, opts)
  end,
}

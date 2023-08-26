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
    local telescope_actions = require("telescope.actions")
    local fb_actions = require("telescope._extensions.file_browser.actions")
    telescope.setup({
      defaults = {
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        mappings = {
          i = {
            ["qq"] = telescope_actions.close,
            ["<C-l>"] = telescope_actions.select_vertical,
            ["<C-j>"] = telescope_actions.select_horizontal
          },
          n = {
            ["qq"] = telescope_actions.close,
            ["<C-l>"] = telescope_actions.select_vertical,
            ["<C-j>"] = telescope_actions.select_horizontal
          },
        },
        layout_strategy = "horizontal",
        layout_config = {
          height = 40,
          width = 160,
          preview_width = 100,
          prompt_position = "top"
        },
        sorting_strategy = "ascending",
      },
      extensions = {
        fileexplorer = {
          theme = "ivy",
          hijack_netrw = true,
          mappings = {
            n = {
              ["a"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              ["o"] = fb_actions.open,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
            },
          },
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
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, opts)
    vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, opts)
    vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, opts)

    -- vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", opts)
    vim.keymap.set("n", "<leader>fb", function()
      require "telescope".extensions.file_browser.file_browser{}
    end, opts)
  end,
}

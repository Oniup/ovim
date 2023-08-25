return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "BurntSushi/ripgrep",
    "nvim-lua/plenary.nvim",
  },
  branch = "0.1.2",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, mode = "n" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  mode = "n" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end,    mode = "n" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end,  mode = "n" },
  },
  config = function()
    local telescope_actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        border = true,
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
      }
    })

    local tel_opts = { noremap = true }
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, tel_opts)
    vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, tel_opts)
    vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, tel_opts)
    vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, tel_opts)
  end
}

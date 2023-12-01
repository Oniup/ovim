return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>e", mode = "n" }
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      hijack_cursor = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      actions = {
        file_popup = {
          open_win_config = {
            border = "single",
          },
        },
      },
      renderer = {
        root_folder_label = false,
        indent_width = 1,
      },
    })

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>",
      { noremap = true, silent = true })
  end
}

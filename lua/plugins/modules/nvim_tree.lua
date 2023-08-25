return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>e", ":NvimTreeToggle<CR>", mode = "n" }
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false
      },
    })
  end
}

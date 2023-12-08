return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufEnter",
  opts = {
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
  }
}

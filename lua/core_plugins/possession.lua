local M = {}

M.plugin = {
  "jedrzejboczar/possession.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    silent = true,
    load_silent = true,
    logfile = true,
    commands = {
      save = "SeSave",
      load = "SeLoad",
      rename = "SeRename",
      close = "SeClose",
      delete = "SeDelete",
      show = "SeShow",
      list = "SeList",
    },
    plugins = {
      dap = true,
      dapui = false,
      delete_buffers = true,
      nvim_tree = false,
      symbols_outline = false,
    },
    telescope = {
      previewer = {
        enabled = false,
      },
      list = {
        default_action = "load",
        mappings = {
          save = { n = "x", i = "<c-x>" },
          load = { n = "l", i = "<c-v>" },
          delete = { n = "<Del>", i = "<c-t>" },
          rename = { n = "r", i = "<c-r>" },
        },
      },
    },
  },
  config = function(_, opts)
    require("possession").setup(opts)

    local telescope = require("telescope")
    telescope.load_extension("possession")
  end,
}

return M

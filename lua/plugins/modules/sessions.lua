return {
  "jedrzejboczar/possession.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  config = function()
    require("possession").setup({
      silent = true,
      load_silent = true,
      logfile = true,
      commands = {
        save = "SessionSave",
        load = "SessionLoad",
        rename = "SessionRename",
        close = "SessionClose",
        delete = "SessionDelete",
        show = "SessionShow",
        list = "SessionList",
      },
      autosave = {
        on_start = true,
        on_quit = true,
      },
      plugins = {
        dap = true,
        dapui = false,
        delete_buffers = true,
        nvim_tree = true,
        symbols_outline = true,
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
    })

    local telescope = require("telescope")
    telescope.load_extension("possession")
    vim.keymap.set("n", "<leader>sd", telescope.extensions.possession.list, { noremap = true, silent = true })
  end
}

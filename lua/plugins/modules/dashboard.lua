return {
  "glepnir/dashboard-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "ahmedkhalf/project.nvim",
  },
  event = "VimEnter",
  config = function()
    local header = {
      " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
      " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
      " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
      " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
      " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
      " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
      "",
      "v" .. vim.version().major .. "." .. vim.version().minor,
      "",
    }

    vim.api.nvim_create_user_command("SetCurrentDir", function(opts)
      vim.api.nvim_set_current_dir(opts.fargs)
    end, { nargs = 1 })

    local center = {
      {
        desc = "Projects",
        icon = "    ",
        key = "p",
        action = "Telescope projects",
      },
      {
        desc = " Config",
        icon = "    ",
        key = "c",
        action = function()
          local config_dir = "~/.config/nvim"
          if vim.fn.has("win32") then
            config_dir = "~/AppData/Local/nvim"
          end
          require("telescope.builtin").find_files({ cwd = config_dir })
          vim.api.nvim_set_current_dir(config_dir)
        end,
      },
    }

    local function center_header()
      local header_height = #header
      local center_height = #center * 2
      local dashboard_height = header_height + center_height

      local win_height = vim.fn.winheight(0)
      local padding = (win_height - dashboard_height) / 2

      local centerd_header = {}
      local i = 0
      while i < padding do
        table.insert(centerd_header, " ")
        i = i + 1
      end
      for _, line in ipairs(header) do
        centerd_header[i] = line
        i = i + 1
      end

      return centerd_header
    end

    local highlights = {
      DashboardHeader = { default = true, link = "Keyword" },
      DashboardIcon = { default = true, link = "Structure" },
      DashboardDesc = { default = true, link = "Operator" },
      DashboardShotCut = { default = true, link = "String" },
      DashboardKey = { default = true, link = "String" },
    }

    for name, value in pairs(highlights) do
      vim.api.nvim_set_hl(0, name, value)
    end

    require("dashboard").setup({
      theme = "doom",
      config = {
        header = center_header(),
        center = center,
        footer = {}
      }
    })
  end
}

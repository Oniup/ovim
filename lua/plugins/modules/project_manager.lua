return {
  "ahmedkhalf/project.nvim",
  depedencies = {
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "ProjectRoot",
  },
  config = function()
    require("project_nvim").setup({
      manual_mode = true,
    })

    local telescope = require("telescope")
    telescope.load_extension("projects")

    vim.api.nvim_create_user_command(
      "OpenProject",
      ":Telescope projects", {})
  end,
}

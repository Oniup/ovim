return {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "OpenProject",
    "ProjectRoot",
  },
  config = function()
    require("project_nvim").setup({
      manual_mode = true,
    })
    require("telescope").load_extension("projects")

    vim.api.nvim_create_user_command(
      "OpenProject",
      ":Telescope projects", {})
  end
}

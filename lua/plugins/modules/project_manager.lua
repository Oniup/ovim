return {
  "ahmedkhalf/project.nvim",
  depedencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "ProjectRoot",
  },
  config = function()
    require("project_nvim").setup({
      manual_mode = true,
      patters = {},
    })

    local telescope = require("telescope")
    telescope.load_extension("projects")

    vim.api.nvim_create_user_command("SetProject", function()
    local file = io.open(vim.fn.stdpath("data") .. "/project_nvim/project_history", "a")
      if file ~= nil then
        file:write("\n" .. vim.fn.getcwd())
        file:close()
      end
    end, {})

    vim.api.nvim_create_user_command(
      "OpenProject",
      ":Telescope projects", {})
  end,
}

return {
  "Oniup/dotnet.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  ft = { "cs", "sln", "csvproj" },
  cmd = { "DotnetInitSln" },
  config = function()
    require("dotnet").setup({
      version = "net6.0",
    })
  end
}

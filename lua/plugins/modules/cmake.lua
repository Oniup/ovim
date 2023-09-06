return {
  "Oniup/cmake.nvim",
  ft = { "cpp", "c", "h", "hpp" },
  config = function()
    require("cmake").setup({
      enable_compile_commands = true,
      -- show_command_in_output_buffer = true,
      kits = {
        {
          type = "Debug",
          generator = "Ninja",
          c = "gcc",
          cxx = "g++",
        },
        {
          type = "Release",
          generator = "Ninja",
          c = "gcc",
          cxx = "g++"
        }
      }
    })
  end,
}

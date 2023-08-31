return {
  "Oniup/ignite.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("ignite").setup()
    vim.cmd([[
      syntax enable
      colorscheme ignite
    ]])
  end
}

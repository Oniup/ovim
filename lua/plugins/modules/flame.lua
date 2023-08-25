return {
  "Oniup/flame.nvim",
  lazy = false,
  dependencies = {
    "rktjmp/lush.nvim",
  },
  config =  function()
    vim.cmd([[syntax enable]])
    vim.cmd.colorscheme("flame")
  end,
}

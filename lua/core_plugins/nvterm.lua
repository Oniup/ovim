return {
  "NvChad/nvterm",
  -- lazy = "VeryLazy",
  event = "BufEnter",
  config = function()
    require("nvterm").setup()
    vim.api.nvim_create_autocmd("TermOpen",
      { pattern = "term://*", command = "setlocal nospell" })

    vim.cmd [[:packadd termdebug]]
  end,
}

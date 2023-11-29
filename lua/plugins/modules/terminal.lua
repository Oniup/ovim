return {
  "NvChad/nvterm",
  keys = {
    { "<A-i>", mode = "n" }
  },
  lazy = "VeryLazy",
  config = function()
    require("nvterm").setup()
    vim.keymap.set({ "n", "t" }, "<A-i>", function()
      require("nvterm.terminal").toggle("horizontal")
    end, { noremap = true, silent = true })

    vim.api.nvim_create_autocmd("TermOpen",
      { pattern = "term://*", command = "setlocal nospell" })

    vim.cmd [[:packadd termdebug]]
  end,
}

return {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>nf", mode = "n" },
  },
  config = function()
    local neogen = require("neogen")
    neogen.setup({
      enabled = true,
      languages = {
        ["cpp.doxygen"] = require("neogen.configurations.cpp"),
        ["c.doxygen"] = require("neogen.configurations.c"),
        ["cs.xmldoc"] = require("neogen.configurations.cs"),
      },
    })

    vim.keymap.set("n", "<leader>nf", neogen.generate,
      { noremap = true, silent = true })
  end
}

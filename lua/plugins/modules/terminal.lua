return {
  "caenrique/buffer-term.nvim",
  keys = {
    { "<A-1>" }
  },
  config = function()
    local terminal = require("buffer-term")
    terminal.setup()

    vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true })
    vim.keymap.set({ "n", "t" }, "<A-1>", function() terminal.toggle("a") end,
      { noremap = true, silent = true })

    local disable_spellcheck_in_terminal = vim.api.nvim_create_augroup(
      "disable_spellcheck_in_terminal", { clear = true })
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*", -- disable spellchecking in the embedded terminal
      command = "setlocal nospell",
      group = disable_spellcheck_in_terminal,
    })
  end,
}

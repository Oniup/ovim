local M = {}

M.plugin = {
  "NvChad/nvterm",
  event = "BufEnter",
  config = true,
  init = function()
    vim.api.nvim_create_autocmd("TermOpen",
      { pattern = "term://*", command = "setlocal nospell" })

    vim.cmd [[:packadd termdebug]]
  end
}

return M

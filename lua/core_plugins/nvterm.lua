local M = {}

M.name = "nvterm"

M.info = {
  "NvChad/nvterm",
  event = "BufEnter",
}

M.after_setup = function()
  vim.api.nvim_create_autocmd("TermOpen",
    { pattern = "term://*", command = "setlocal nospell" })

  vim.cmd [[:packadd termdebug]]
end

return M

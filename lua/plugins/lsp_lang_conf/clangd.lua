local M = {}

M.enable_keybindings = function()
  vim.keymap.set("n", "<leader>o", "<cmd>ClangdSwitchSourceHeader<CR>", { silent = true })
end

M.settings = nil

return M

local M = {}

M.on_startup = function()
  if vim.g.neovide then
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_animation_length = 0.03
    -- vim.o.guifont = "FiraCode Nerd Font Mono:h17"
    vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h16"
  end
end

return M

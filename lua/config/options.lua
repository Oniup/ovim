local M = {}

local vim_opts = {
  relativenumber = true,
  clipboard = "unnamedplus",
  belloff = "all",    -- Turn the annoying bell sounds off, LEAVE ME ALONE
  visualbell = false, -- Stop beeping for non-error errors, FFS

  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",

  spelllang = { "en", "cjk" },   -- Enable spelling for English
  spellsuggest = { "best", 10 }, -- Show x the best matching results
  spell = true,                  -- Enable spell checker
  spellcapcheck = "",            -- Don't check for capital letters

  termguicolors = true,          -- Use 24bit colors
  guicursor = "n-v-c-sm:block,i-ci-ve:hor10,r-cr-o:hor10",
  synmaxcol = 200,               -- Don't bother syntax highlighting long lines
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "cs",
  callback = function()
    vim.opt.shiftround = 4
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end
})

M.vim_opts = require("core.utils").set_term_shell(vim_opts)

return M

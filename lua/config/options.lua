local M = {}

vim.g.load_doxygen_syntax = 1
vim.g.doxygen_enhanced_colour = 1
vim.loader.enable()

local vim_opts = {
  number = true,
  relativenumber = true,
  showmode = false,
  signcolumn = "yes", -- number: for thinner lines
  cmdheight = 1,
  cursorline = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  shiftround = true, -- always indent by multiple of shiftwidth
  scrolloff = 5,     -- Start scrolling x lines before edge of view port
  splitbelow = true, -- Open horizontal splits below the current one
  splitright = true, -- Open vertical splits right of the current one
  autoindent = true,
  fileencoding = "utf-8",
  expandtab = true, -- Always use spaces instead of tabs
  smarttab = true,
  smartindent = true,
  smartcase = true,   -- Use case sensitive search if capital letter is present
  wrap = false,       -- Word wrapping when reaches the edge of the viewport
  mouse = "a",        -- Enables mouse functionality
  clipboard = "unnamedplus",
  hidden = true,      -- allows you to hide buffers with unsaved changes without being prompted

  belloff = "all",    -- Turn the annoying bell sounds off, LEAVE ME ALONE
  visualbell = false, -- Stop beeping for non-error errors, FFS

  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",

  inccommand = "split",          -- Line preview of :s results
  incsearch = true,              -- Do incremental search
  ignorecase = true,             -- Ignore case in search

  list = true,                   --Show white spaces

  spelllang = { "en", "cjk" },   -- Enable spelling for English
  spellsuggest = { "best", 10 }, -- Show x the best matching results
  spell = true,                  -- Enable spell checker
  spellcapcheck = "",            -- Don't check for capital letters
  backup = false,                -- Don't use generated backup files
  swapfile = false,              -- Don't create swapfiles
  writebackup = false,           -- Don't write a backup file

  termguicolors = true,          -- Use 24bit colors
  guicursor = "n-v-c-sm:block,i-ci-ve:hor10,r-cr-o:hor10",
  synmaxcol = 200,               -- Don't bother syntax highlighting long lines
  completeopt = "menuone,noselect,noinsert",
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

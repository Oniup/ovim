local M = {}

M.leader_key = " "

M.vim_opts = {
  number = true,
  relativenumber = false,
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
  smarttab = true,
  smartindent = true,
  hidden = true,        -- allows you to hide buffers with unsaved changes without being prompted

  incsearch = true,     -- Do incremental search
  ignorecase = true,    -- Ignore case in search

  termguicolors = true, -- Use 24bit colors
  synmaxcol = 200,      -- Don't bother syntax highlighting long lines
  completeopt = "menuone,noselect,noinsert",

  shortmess = vim.opt.shortmess
      + "A"  -- Ignore annoying swapfile messages
      + "I"  -- No spash screen
      + "O"  -- File-read message overrites previous
      + "T"  -- Truncate non-file messages in middle
      + "W"  -- Don't echo '[w]/[written]' when writing
      + "o"  -- Overwrite file-written message
      + "t"  -- Truncate file messages at start
      + "c", -- Don't show matching messages

  -- Option  to influence how Vim formats text (:help fo-table)
  formatoptions = vim.opt.formatoptions
      - "a"  -- Don't autoformat
      - "t"  -- Don't autoformat my code, have linters for that
      + "l"  -- Long lines are not broken up
      + "j"  -- Remove comment leader when joining comments
      + "r"  -- Continue comment with enter
      - "o"  -- Don't continue comment with w/ o and o
      + "n", -- Smart auto indenting inside numbered lists

  listchars = vim.opt.listchars
      + "nbsp:⦸" -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
      + "tab:▷┅" -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
      + "extends:»" -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
      + "precedes:«" -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
      + "trail:•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

return M

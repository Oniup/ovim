local M = {
  number = true,
  relativenumber = false,

  showmode = false,
  signcolumn = "yes", -- number: for thinner lines
  laststatus = 0,
  cmdheight = 1,
  cursorline = true,

  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  shiftround = true, -- always indent by multiple of shiftwidth
  expandtab = true, -- Always use spaces instead of tabs
  scrolloff = 5, -- Start scrolling x lines before edge of view port

  splitbelow = true, -- Open horizontal splits below the current one
  splitright = true, -- Open vertical splits right of the current one
  autoindent = true,

  fileencoding = "utf-8",
  smarttab = true,
  smartindent = true,
  hidden = true, -- allows you to hide buffers with unsaved changes without being prompted
  wrap = false,

  mouse = "a", -- Enables mouse functionality
  list = true, -- Show white spaces

  inccommand = "split", -- Line preview of :s results
  incsearch = true, -- Do incremental search
  ignorecase = true, -- Ignore case in search

  termguicolors = true, -- Use 24bit colors
  synmaxcol = 200, -- Don't bother syntax highlighting long lines
  completeopt = "menuone,noselect,noinsert",

  backup = false, -- Don't use generated backup files
  swapfile = false, -- Don't create swapfiles
  writebackup = false, -- Don't write a backup file

  spelllang = { "en", "cjk" }, -- Enable spelling for English
  spellsuggest = { "best", 10 }, -- Show x the best matching results
  spell = true, -- Enable spell checker
  spellcapcheck = "", -- Don't check for capital letters

  fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
  },

  listchars = {
    nbsp = "⦸",
    tab = "▷┅",
    extends = "»",
    precedes = "«",
    trail = "•",
  },

  shortmess = vim.opt.shortmess
    + "A" -- Ignore annoying swapfile messages
    + "I" -- No splash screen
    + "O" -- File-read message overrates previous
    + "T" -- Truncate non-file messages in middle
    + "W" -- Don't echo '[w]/[written]' when writing
    + "o" -- Overwrite file-written message
    + "t" -- Truncate file messages at start
    + "c", -- Don't show matching messages

  -- Influence how Vim formats text (:help fo-table)
  formatoptions = vim.opt.formatoptions
    - "a" -- Don't autoformat
    - "t" -- Don't autoformat my code, have linter's for that
    + "l" -- Long lines are not broken up
    + "j" -- Remove comment leader when joining comments
    + "r" -- Continue comment with enter
    - "o" -- Don't continue comment with w/ o and o
    + "n", -- Smart auto indenting inside numbered lists
}

if vim.fn.has("win32") then
  if vim.fn.executable("pwsh") then
    M.shell = "pwsh"
  else
    M.shell = "powershell"
  end
  M.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
    .. "[Console]::InputEncoding=[Console]::OutputEncoding="
    .. "[System.Text.Encoding]::UTF8;"
  M.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  M.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  M.shellquote = ""
  M.shellxquote = ""
end

return M

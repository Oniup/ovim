local apply_options = function(opts)
  for name, option in pairs(opts) do
    vim.opt[name] = option
  end
end

local options = {
  number = true,
  relativenumber = true,
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

  -- laststatus = 4,                -- Use global status line

  spelllang = { "en", "cjk" },   -- Enable spelling for English
  spellsuggest = { "best", 10 }, -- Show x the best matching results
  spell = true,                  -- Enable spell checker
  spellcapcheck = "",            -- Don't check for capital letters
  backup = false,                -- Don't use generated backup files
  swapfile = false,              -- Don't create swapfiles
  writebackup = false,           -- Don't write a backup file

  termguicolors = true,          -- Use 24bit colors
  synmaxcol = 200,               -- Don't bother syntax highlighting long lines
  completeopt = "menuone,noselect,noinsert",
  switchbuf = "usetab",          -- Try to reuse windows/tabs when switching buffers

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
apply_options(options)

if vim.fn.has("win32") then
  local powershell_opts = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command " ..
        "[Console]::InputEncoding=[Console]::OutputEncoding=" ..
        "[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }
  apply_options(powershell_opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".cs",
  callback = function()
    vim.opt.shiftround = 4
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end
})

vim.loader.enable()

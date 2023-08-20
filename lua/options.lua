local options = {
	number = true,
	relativenumber = true,
	signcolumn = "yes",
	
	tabstop = 2,
	shiftwidth = 2,
	softtabstop = 2,
	autoindent = true,
	smarttab = true,
	smartindent = true,
	smartcase = true,

	wrap = false,
	swapfile = false,

	mouse = a,
	incsearch = true,
	ignorecase = true,
	clipboard = "unnamedplus",

	spelllang= { "en", "cjk" },
	spellsuggest= { "best", 10 },
	spell = true,

	fileencoding = "utf-8",
	termguicolors = true,
	backup = false,
	writebackup = false,
	updatetime = 300,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end


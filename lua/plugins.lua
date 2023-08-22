vim.cmd([[packadd packer.nvim]])
vim.cmd([[packadd termdebug]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- Libraries that a lot of plugins use
	use "nvim-lua/plenary.nvim"
	use "nvim-tree/nvim-web-devicons"

	-- Syntax highlighting
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use "rebelot/kanagawa.nvim"

	-- Status lines
	use "nvim-lualine/lualine.nvim"
	use { "akinsho/bufferline.nvim", tag = "*" }

	-- Auto pair
	use { "jiangmiao/auto-pairs" }

	-- Fuzzy finder
	use "BurntSushi/ripgrep"
	use { "nvim-telescope/telescope.nvim", branch = "0.1.2" }

	-- File explorer
	use "nvim-tree/nvim-tree.lua"

	-- Project Manager
	use "ahmedkhalf/project.nvim"

	-- LSP
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig.nvim"
	use "neovim/nvim-lspconfig"
	use "simrat39/rust-tools.nvim"

	-- Debugger
	use "puremourning/vimspector"

	-- Auto completion
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",

			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	}
end)

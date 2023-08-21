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
	use { "ellisonleao/gruvbox.nvim" }

	-- Fuzzy finder
	use "BurntSushi/ripgrep" 
	-- use {
	-- 	"nvim-telescope/telescope-fzf-native.nvim",
	-- 	run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
	-- }
	use { "nvim-telescope/telescope.nvim", branch = "0.1.2" }

	-- Code completion
	use { "neoclide/coc.nvim", branch = "release" }

	-- Status lines
	use "nvim-lualine/lualine.nvim"
	use { "akinsho/bufferline.nvim", tag = "*" }

	-- File explorer
	use "nvim-tree/nvim-tree.lua"

	-- Auto pair
	use { "jiangmiao/auto-pairs" }

	-- CMake
	use "ilyachur/cmake4vim"
	use "SantinoKeupp/telescope-cmake4vim.nvim"
end)

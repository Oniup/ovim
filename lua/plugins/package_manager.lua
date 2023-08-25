vim.cmd([[packadd packer.nvim]])

local plugins = {
  -- Packer can manage itself
  "wbthomason/packer.nvim",

  -- Libraries that a lot of plugins use
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "rktjmp/lush.nvim",

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  },
  "Oniup/flame.nvim",
  "m-demare/hlargs.nvim",

  -- Status lines
  "nvim-lualine/lualine.nvim",
  {
    "akinsho/bufferline.nvim",
    tag = "*"
  },

  -- Auto pair
  "jiangmiao/auto-pairs",

  -- Fuzzy finder
  "BurntSushi/ripgrep",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.2"
  },

  -- File explorer
  "nvim-tree/nvim-tree.lua",

  -- Project Manager
  "ahmedkhalf/project.nvim",

  -- Comments
  "folke/todo-comments.nvim",
  "numToStr/Comment.nvim",

  -- Toggle terminal
  "caenrique/buffer-term.nvim",

  -- Cheatsheet
  "sudormrfbin/cheatsheet.nvim",

  -- CMake
  "Civitasv/cmake-tools.nvim",

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "simrat39/rust-tools.nvim",

  -- Debugger
  "puremourning/vimspector",

  -- Auto completion
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    requires = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    }
  }
  -- {
  --   "hrsh7th/nvim-cmp",
  --   requires = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     "hrsh7th/cmp-nvim-lsp-signature-help",

  --     "hrsh7th/cmp-vsnip",
  --     "hrsh7th/vim-vsnip",

  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --   },
  -- }
}

-- plugins or configurations that are not pushed to repo
local custom_status, custom_plugins = pcall(require, "custom.plugins")
if custom_status then
  table.insert(plugins, custom_plugins)
end

return require("packer").startup(function(use)
  for _, plugin in pairs(plugins) do
    use(plugin)
  end
end)

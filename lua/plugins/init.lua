return {
  -- Visual Quality -----------------------------------------------------------
  {
    "Oniup/ignite.nvim",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    buld = ":TSUpdate",
  },
  {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "akinsho/bufferline.nvim",
    name = "bufferline",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  },

  -- Navigation ---------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvimtree",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/popup.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -s. -bbuild -dcmake_build_type=release && cmake --build build --config release && cmake --install build --prefix build",
      },
      "burntsushi/ripgrep",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },
  {
    "jedrzejboczar/possession.nvim",
    cmd = "Telescope possession list",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "telescope",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    name = "toggleterm",
    cmd = "ToggleTerm",
  },

  -- Auto Completion ----------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    name = "cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    event = "InsertEnter",
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
  },
  {
    "numToStr/Comment.nvim",
    event = "InsertEnter",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
  },

  -- Language Server Protocol --------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    dependencies = {
      "mason",
      "lsp-progress",
      "null-ls",
      "stevearc/dressing.nvim",
    },
  },
  {
    "linrongbin16/lsp-progress.nvim",
    name = "lsp-progress",
    dependencies = {
      "lspconfig",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lazy_load_plugin_on_file_open = false,
    },
  },
  {
    "nvimtools/none-ls.nvim",
    name = "null-ls",
    dependencies = {
      "lspconfig",
    },
    opts = {
      lazy_load_plugin_on_file_open = false,
    },
  },
  {
    "williamboman/mason.nvim",
    name = "mason",
    dependencies = {
      "lspconfig",
      "nvim-tree/nvim-web-devicons",
      "williamboman/mason-lspconfig.nvim",
    },
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUpdate",
      "MasonUninstallAll",
      "MasonLog",
    },
  },

  -- Plugin Utility APIs ------------------------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      lazy_load_plugin_on_file_open = false,
    },
  },
}

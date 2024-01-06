return {
  {
    "Oniup/ignite.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvimtree",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    buld = ":TSUpdate",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",

      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -s. -bbuild -dcmake_build_type=release && cmake --build build --config release && cmake --install build --prefix build",
      },
      "burntsushi/ripgrep",
      "nvim-telescope/telescope-ui-select.nvim",
    }
  },
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
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "linrongbin16/lsp-progress.nvim",
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "jedrzejboczar/possession.nvim",
    cmd = "Telescope possession list",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
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
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  },
}

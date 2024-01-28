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
        opts = {
            setup_module_name = "nvim-treesitter.configs",
            lazy_on_file_open = true,
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        dependencies = {
            "devicons",
        },
        opts = {
            lazy_on_file_open = true,
        },
    },
    {
        "romgrk/barbar.nvim",
        name = "barbar",
        dependencies = {
            "devicons",
            "gitsigns",
        },
        opts = {
            lazy_on_file_open = true,
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
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
            "devicons",
            "dressing",
        },
        opts = {
            setup_module_name = "nvim-tree",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        name = "telescope",
        cmd = { "Telescope" },
        dependencies = {
            "nvim-lua/popup.nvim",
            "burntsushi/ripgrep",
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
    {
        "jedrzejboczar/possession.nvim",
        name = "possession",
        cmd = {
            "Telescope possession list",
            "SeSave",
            "SeLoad",
            "SeClose",
            "SeDelete",
            "SeShow",
            "SeList",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "telescope",
        },
    },
    {
        "goolord/alpha-nvim",
        name = "alpha",
        event = "BufEnter",
        dependencies = {
            "devicons",
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
        },
        opts = {
            lazy_on_file_open = true,
        },
    },
    {
        "windwp/nvim-autopairs",
        name = "autopairs",
        event = { "InsertEnter" },
        opts = {
            setup_module_name = "nvim-autopairs",
        },
    },
    {
        "numToStr/Comment.nvim",
        name = "comment",
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        },
        opts = {
            setup_module_name = "Comment",
        },
    },

    -- Language Server Protocol --------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        dependencies = {
            "mason",
            "null-ls",
            "dressing",
            "lsp-progress",
        },
        opts = {
            enable_setup = false,
        },
    },
    {
        "stevearc/dressing.nvim",
        name = "dressing",
    },
    {
        "linrongbin16/lsp-progress.nvim",
        name = "lsp-progress",
        dependencies = {
            "lspconfig",
            "devicons",
        },
        opts = {
            lazy_on_file_open = true,
        },
    },
    {
        "nvimtools/none-ls.nvim",
        name = "null-ls",
        dependencies = {
            "lspconfig",
            "nvim-lua/plenary.nvim",
        },
        opts = {
            enable_setup = false,
        },
    },
    {
        "williamboman/mason.nvim",
        name = "mason",
        dependencies = {
            "lspconfig",
            "devicons",
            "williamboman/mason-lspconfig.nvim",
        },
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUpdate",
            "MasonUninstallAll",
            "MasonLog",
        },
        opts = {
            enable_setup = false,
        },
    },

    -- Debug Adapter Protocol ---------------------------------------------------
    {
        "mfussenegger/nvim-dap",
        name = "dap",
        dependencies = {
            "mason",
            "jay-babu/mason-nvim-dap.nvim",
        },
        cmd = {
            "DapToggleBreakpoint",
        },
        opts = {
            enable_setup = false,
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        name = "dapui",
        dependencies = {
            "dap",
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap",
        },
    },

    -- Plugin Utility APIs ------------------------------------------------------
    {
        "nvim-tree/nvim-web-devicons",
        name = "devicons",
        opts = {
            setup_module_name = "nvim-web-devicons",
        },
    },
}

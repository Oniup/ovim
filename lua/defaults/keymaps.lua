return {
  n = {
    --- Buffer Navigation
    ---------------------------------------------------------------------------
    ["<S-l>"]     = { ":bnext<CR>" },
    ["<S-h>"]     = { ":bprevious<CR>" },

    --- Window Navigation
    ---------------------------------------------------------------------------
    ["<C-h>"]     = { "<C-w>h", "Navigate cursor to the left side window" },
    ["<C-j>"]     = { "<C-w>j", "Navigate cursor to the lower window" },
    ["<C-k>"]     = { "<C-w>k", "Navigate cursor to the upper window" },
    ["<C-l>"]     = { "<C-w>l", "Navigate cursor to the right side window" },

    --- Resize with arrows
    ---------------------------------------------------------------------------
    ["<C-Up>"]    = { ":resize -2<CR>", "Resize window" },
    ["<C-Down>"]  = { ":resize +2<CR>", "Resize window" },
    ["<C-Left>"]  = { ":vertical resize -2<CR>", "Resize window" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "Resize window" },
  },
  --- Load when initializing plugin
  -----------------------------------------------------------------------------
  ["nvim-tree.lua"] = {
    n = {
      ["<leader>e"] = { ":NvimTreeToggle<CR>", "Toggle file explorer" }
    },
  },
  ["telescope.nvim"] = {
    n = {
      ["<leader>ff"] = {
        function() require("telescope.builtin").find_files() end,
        "Find file"
      },
      ["<leader>fg"] = {
        function() require("telescope.builtin").live_grep() end,
        "Live Grep: Find matching string of text throughout project"
      },
      ["<leader>fh"] = {
        function() require("telescope.builtin").help_tags() end,
        "Find help vim or plugin .txt"
      },
    },
  },
  ["nvterm"] = {
    n = {
      ["<A-i>"] = {
        function() require("nvterm.terminal").toggle("horizontal") end }
    },
    t = {
      ["<A-i>"] = {
        function() require("nvterm.terminal").toggle("horizontal") end }
    },
  },
}

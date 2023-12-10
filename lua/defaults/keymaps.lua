return {
  leader = ",",
  general = {
    n = {
      --- Buffer Navigation
      ---------------------------------------------------------------------------
      ["<S-l>"]     = { ":bnext<CR>", "Next Buf" },
      ["<S-h>"]     = { ":bprevious<CR>", "Previous Buf" },

      --- Window Navigation
      ---------------------------------------------------------------------------
      ["<C-h>"]     = { "<C-w>h", "Cursor -> Left Side Window" },
      ["<C-j>"]     = { "<C-w>j", "Cursor -> Lower Window" },
      ["<C-k>"]     = { "<C-w>k", "Cursor -> Upper Window" },
      ["<C-l>"]     = { "<C-w>l", "Cursor -> Right Side Window" },

      --- Resize with arrows
      ---------------------------------------------------------------------------
      ["<C-Up>"]    = { ":resize -2<CR>", "Resize Window" },
      ["<C-Down>"]  = { ":resize +2<CR>", "Resize Window" },
      ["<C-Left>"]  = { ":vertical resize -2<CR>", "Resize Window" },
      ["<C-Right>"] = { ":vertical resize +2<CR>", "Resize Window" },
    },
  },
  plugins = {
    ["nvim-tree.lua"] = {
      n = {
        ["<leader>e"] = { ":NvimTreeToggle<CR>", "Toggle File Explorer" }
      },
    },
    ["telescope.nvim"] = {
      n = {
        ["<leader>fc"] = {
          function() require("telescope.builtin").current_buffer_fuzzy_find() end,
          "Find in Current Buf"
        },
        ["<leader>ff"] = {
          function() require("telescope.builtin").find_files() end,
          "Find File"
        },
        ["<leader>fg"] = {
          function() require("telescope.builtin").live_grep() end,
          "Live Grep"
        },
        ["<leader>fh"] = {
          function() require("telescope.builtin").help_tags() end,
          "Find Vim Doc"
        },
      },
    },
    ["nvterm"] = {
      n = {
        ["<A-i>"] = {
          function() require("nvterm.terminal").toggle("horizontal") end,
          "Toggle Term"
        }
      },
      t = {
        ["<A-i>"] = {
          function() require("nvterm.terminal").toggle("horizontal") end,
          "Toggle Term"
        }
      },
    },
  }
}

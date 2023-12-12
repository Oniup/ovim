return {
  mapping_modes = { "n", "i", "t", "x", "c" },
  default_opts = { silent = true },
  general = {
    n = {
      ["<s-l>"] = { ":bnext<cr>", desc = "Next buf" },
      ["<s-h>"] = { ":bprevious<cr>", desc = "Previous buf" },

      ["<c-h>"] = { "<c-w>h", desc = "Cursor -> left side window" },
      ["<c-j>"] = { "<c-w>j", desc = "Cursor -> lower window" },
      ["<c-k>"] = { "<c-w>k", desc = "Cursor -> upper window" },
      ["<c-l>"] = { "<c-w>l", desc = "Cursor -> right side window" },

      ["<leader>sj"] = { ":split<cr>", desc = "Split window below" },
      ["<leader>sl"] = { ":vsplit<cr>", desc = "Split window to the right" },
    },
    i = {
      ["jk"] = { "<esc>", desc = "Esc insert mode" },
    },
  },
  plugins = {
    ["nvim-tree.lua"] = {
      n = {
        ["<leader>e"] = { ":NvimTreeToggle<cr>", desc = "Toggle dir explorer" },
      },
    },
    ["telescope.nvim"] = {
      n = {
        ["<leader>fc"] = { function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Find in current buf" },
        ["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find file" },
        ["<leader>fg"] = { function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
        ["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find vim help tag" },
        ["<leader>fb"] = { function() require("telescope").extensions.file_browser.file_browser() end, desc = "Open file browser" },
      },
    },
    ["nvterm"] = {
      n = {
        ["<A-i>"] = { function() require("nvterm.terminal").toggle("horizontal") end, desc = "Toggle Term" },
      },
      t = {
        ["<A-i>"] = { function() require("nvterm.terminal").toggle("horizontal") end, desc = "Toggle Term",
        },
      },
    },
    ["neogen"] = {
      n = {
        ["<leader>nf"] = {
          function() require("neogen").generate({}) end,
          desc = "Gen comment template"
        },
      },
    },
    ["possession.nvim"] = {
      n = {
        ["<leader>se"] = {
          function() require("telescope").extensions.possession.list() end,
          desc = "Open Sessions"
        },
      },
    },
  },
}

local telescope = function()
  return require("telescope")
end

local telescope_builtin = function()
  return require("telescope.builtin")
end

local dap = function()
  return require("dap")
end

return {
  mapping_modes = { "n", "i", "t", "x", "c" },
  default_opts = { silent = true },
  general = {
    n = {
      ["<s-l>"]      = { ":bnext<cr>", desc = "Next buf" },
      ["<s-h>"]      = { ":bprevious<cr>", desc = "Previous buf" },

      ["<c-h>"]      = { "<c-w>h", desc = "Cursor -> left side window" },
      ["<c-j>"]      = { "<c-w>j", desc = "Cursor -> lower window" },
      ["<c-k>"]      = { "<c-w>k", desc = "Cursor -> upper window" },
      ["<c-l>"]      = { "<c-w>l", desc = "Cursor -> right side window" },

      ["<leader>sj"] = { ":split<cr>", desc = "Split window below" },
      ["<leader>sl"] = { ":vsplit<cr>", desc = "Split window to the right" },

      ["<c-Up>"]     = { ":resize -2<CR>", desc = "Resize win -y" },
      ["<c-Down>"]   = { ":resize +2<CR>", desc = "Resize win +y" },
      ["<c-Left>"]   = { ":vertical resize -2<CR>", desc = "Resize win -x" },
      ["<c-Right>"]  = { ":vertical resize +2<CR>", desc = "Resize win +x" },
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
        ["<leader>fc"] = { function() telescope_builtin().current_buffer_fuzzy_find() end, desc = "Find in current buf" },
        ["<leader>ff"] = { function() telescope_builtin().find_files() end, desc = "Find file" },
        ["<leader>fg"] = { function() telescope_builtin().live_grep() end, desc = "Live grep" },
        ["<leader>fh"] = { function() telescope_builtin().help_tags() end, desc = "Find vim help tag" },
        ["<leader>fb"] = { function() telescope().extensions.file_browser.file_browser() end, desc = "Open file browser" },
        ["<leader>fa"] = { function() telescope_builtin().builtin() end, desc = "All builtin funcs" },
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
          function() telescope().extensions.possession.list() end,
          desc = "Open Sessions"
        },
      },
    },
    ["nvim-dap"] = {
      n = {
        ["<F5>"] = { function() dap().continue() end },
        ["<F10>"] = { function() dap().step_over() end },
        ["<F11>"] = { function() dap().step_into() end },
        ["<F12>"] = { function() dap().set_out() end },

        ["<leader>dl"] = { function() require("telescope").extensions.dap.variables() end },
        ["<leader>dt"] = {
          function()
            dap().terminate()
            require("dapui").close()
          end,
          opts = { noremap = true }
        },

        ["<leader>bb"] = { function() dap().toggle_breakpoint() end },
        ["<leader>bc"] = { function() dap().clear_breakpoints() end },
        ["<leader>bl"] = { function() telescope().extensions.dap.list_breakpoints() end },

        ["<leader>dc"] = { function() telescope().extensions.dap.configurations() end },
        ["<leader>dm"] = { function() telescope().extensions.dap.commands() end },
      },
    },
  },
}

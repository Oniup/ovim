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
      ["qq"]         = { "<CMD>bdelete<CR>", desc = "Delete current buffer" },
      ["<S-l>"]      = { "<CMD>bnext<CR>", desc = "Next buf" },
      ["<S-h>"]      = { "<CMD>bprevious<CR>", desc = "Previous buf" },

      ["<C-h>"]      = { "<C-w>h", desc = "Cursor -> left side window" },
      ["<C-j>"]      = { "<C-w>j", desc = "Cursor -> lower window" },
      ["<C-k>"]      = { "<C-w>k", desc = "Cursor -> upper window" },
      ["<C-l>"]      = { "<C-w>l", desc = "Cursor -> right side window" },

      ["<leader>sj"] = { "<CMD>split<CR>", desc = "Split window below" },
      ["<leader>sl"] = { "<CMD>vsplit<CR>", desc = "Split window to the right" },

      ["<C-Up>"]     = { "<CMD>resize -2<CR>", desc = "Resize win -y" },
      ["<C-Down>"]   = { "<CMD>resize +2<CR>", desc = "Resize win +y" },
      ["<C-Left>"]   = { "<CMD>vertical resize -2<CR>", desc = "Resize win -x" },
      ["<C-Right>"]  = { "<CMD>vertical resize +2<CR>", desc = "Resize win +x" },
    },
  },
  lsp = {
    buf = {
      n = {
        ["gd"] = { function() telescope().lsp_definitions() end },
        ["gi"] = { function() telescope().lsp_implementations() end },
        ["gt"] = { function() telescope().lsp_type_definitions() end },
        ["gr"] = { function() telescope().lsp_references() end },
        ["gl"] = { function() telescope().open_float() end },
        ["K"] = { function() vim.lsp.buf.hover() end },
        ["<leader>di"] = { function() telescope().diagnostics() end },
        ["<leader>fo"] = { function() vim.lsp.buf.format() end },
        ["<leader>ca"] = { function() vim.lsp.buf.code_action() end },
        ["<leader>re"] = { function() vim.lsp.buf.rename() end },
        ["<leader>gn"] = { function() vim.diagnostic.goto_next() end },
        ["<leader>gp"] = { function() vim.diagnostic.goto_prev() end },
      }
    },
    lang = {
      {
        ft = { "cpp", "hpp", "ini", "cc", "c", "h" },
        n = {
          ["<leader>o"] = {
            "<CMD>ClangdSwitchSourceHeader<CR>",
            desc = "swap btw h/c",
          },
        },
      },
    },
  },
  plugins = {
    ["file_explorer"] = {
      n = {
        ["<leader>e"] = { "<CMD>NvimTreeToggle<CR>", desc = "Toggle dir explorer" },
      },
    },
    ["terminal"] = {
      n = {
        ["<A-i>"] = {
          function()
            vim.cmd("ToggleTerm direction=horizontal name=toggle_terminal<CR>")
            vim.o.spell = false;
          end,
          desc = "Toggle terminal",
        },
      },
      t = {
        ["<A-i>"] = {
          "<CMD>ToggleTerm direction=horizontal name=toggle_terminal<CR>",
          desc = "Toggle terminal",
        },
      },
    },
    ["telescope"] = {
      n = {
        ["<leader>ff"] = { function() telescope_builtin().find_files() end, desc = "Find file" },
        ["<leader>fs"] = { function() telescope_builtin().current_buffer_fuzzy_find() end, desc = "Find in current buf" },
        ["<leader>fg"] = { function() telescope_builtin().live_grep() end, desc = "Live grep" },
        ["<leader>fh"] = { function() telescope_builtin().help_tags() end, desc = "Find vim help tag" },
        ["<leader>fa"] = { function() telescope_builtin().builtin() end, desc = "All builtin funcs" },
      },
    },
    ["doxygen"] = {
      n = {
        ["<leader>nf"] = {
          function() require("neogen").generate({}) end,
          desc = "Gen comment template"
        },
      },
    },
    ["possession"] = {
      n = {
        ["<leader>se"] = {
          function() telescope().extensions.possession.list() end,
          desc = "Open Sessions"
        },
      },
    },
    ["dap"] = {
      n = {
        ["<F5>"] = { function() dap().continue() end, desc = "Start/Continue debugging" },
        ["<F10>"] = { function() dap().step_over() end, desc = "Step over", },
        ["<F11>"] = { function() dap().step_into() end, desc = "Step into" },
        ["<F12>"] = { function() dap().set_out() end, desc = "Step out" },

        ["<leader>dt"] = {
          function()
            dap().terminate()
            require("dapui").close()
          end,
          opts = { noremap = true },
          desc = "Terminate dap session",
        },

        ["<leader>bb"] = { function() dap().toggle_breakpoint() end, desc = "Toggle breakpoint" },
        ["<leader>bc"] = { function() dap().clear_breakpoints() end, desc = "Clear breakpoints" },
        ["<leader>bl"] = { function() telescope().extensions.dap.list_breakpoints() end, desc = "List breakpoints" },

        ["<leader>dm"] = { function() telescope().extensions.dap.commands() end, desc = "Show dap commands" },
        ["<leader>dc"] = { function() telescope().extensions.dap.configurations() end, desc = "Show dap configurations" },
        ["<leader>dl"] = { function() telescope().extensions.dap.variables() end, desc = "Show dap variables" },
        ["<leader>df"] = { function() telescope().extensions.dap.frames() end, desc = "Show dap frames" },
      },
    },
  },
}

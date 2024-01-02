return {
  mapping_modes = { "n", "i", "t", "x", "c" },
  default_opts = { silent = true },
  general = {
    n = {
      ["qq"] = { "<cmd> bdelete <cr>", desc = "Delete current buffer" },
      ["<S-l>"] = { "<cmd> bnext <cr>", desc = "Next buf" },
      ["<S-h>"] = { "<cmd> bprevious <cr>", desc = "Previous buf" },

      ["<C-h>"] = { "<C-w>h", desc = "Cursor -> left side window" },
      ["<C-j>"] = { "<C-w>j", desc = "Cursor -> lower window" },
      ["<C-k>"] = { "<C-w>k", desc = "Cursor -> upper window" },
      ["<C-l>"] = { "<C-w>l", desc = "Cursor -> right side window" },

      ["<leader>sj"] = { "<cmd> split <cr>", desc = "Split window below" },
      ["<leader>sl"] = {
        "<cmd> vsplit <cr>",
        desc = "Split window to the right",
      },

      ["<C-Up>"] = { "<cmd> resize -2 <cr>", desc = "Resize win -y" },
      ["<C-Down>"] = { "<cmd> resize +2 <cr>", desc = "Resize win +y" },
      ["<C-Left>"] = { "<cmd> vertical resize -2 <cr>", desc = "Resize win -x" },
      ["<C-Right>"] = {
        "<cmd> vertical resize +2 <cr>",
        desc = "Resize win +x",
      },

      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      ["j"] = {
        'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
        "Move down",
        opts = { expr = true },
      },
      ["k"] = {
        'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
        "Move up",
        opts = { expr = true },
      },
    },
  },
  lsp = {
    buf = {
      n = {
        ["gd"] = { "<cmd>  Telescope lsp_definitions <cr>" },
        ["gi"] = { "<cmd>  Telescope lsp_implementations <cr>" },
        ["gt"] = { "<cmd>  Telescope lsp_type_definitions <cr>" },
        ["gr"] = { "<cmd>  Telescope lsp_references <cr>" },
        ["gl"] = { "<cmd>  Telescope open_float <cr>" },
        ["K"] = {
          function()
            vim.lsp.buf.hover()
          end,
        },

        ["<leader>di"] = { "<cmd>  Telescope diagnostics() <cr>" },
        ["<leader>fo"] = {
          function()
            vim.lsp.buf.format()
          end,
        },
        ["<leader>ca"] = {
          function()
            vim.lsp.buf.code_action()
          end,
        },
        ["<leader>re"] = {
          function()
            vim.lsp.buf.rename()
          end,
        },
        ["<leader>gn"] = {
          function()
            vim.diagnostic.goto_next()
          end,
        },
        ["<leader>gp"] = {
          function()
            vim.diagnostic.goto_prev()
          end,
        },
      },
    },
    lang = {
      {
        ft = { "cpp", "hpp", "ini", "cc", "c", "h" },
        n = {
          ["<leader>o"] = {
            "<cmd> ClangdSwitchSourceHeader <cr>",
            desc = "swap btw h/c",
          },
        },
      },
    },
  },
  plugins = {
    nvimtree = {
      n = {
        ["<leader>e"] = {
          "<cmd> NvimTreeToggle <cr>",
          desc = "Toggle dir explorer",
        },
      },
    },
    toggleterm = {
      n = {
        ["<A-i>"] = {
          function()
            vim.cmd("ToggleTerm direction=horizontal name=toggle_terminal <cr>")
            vim.o.spell = false
          end,
          desc = "Toggle terminal",
        },
      },
      t = {
        ["<A-i>"] = {
          "<cmd> ToggleTerm direction=horizontal name=toggle_terminal <cr>",
          desc = "Toggle terminal",
        },
      },
    },
    telescope = {
      n = {
        ["<leader>ff"] = {
          "<cmd> Telescope find_files <cr>",
          desc = "Find file",
        },
        ["<leader>fs"] = {
          "<cmd> Telescope current_buffer_fuzzy_find <cr>",
          desc = "Find in current buf",
        },
        ["<leader>fg"] = {
          "<cmd> Telescope live_grep <cr>",
          desc = "Live grep",
        },
        ["<leader>fh"] = {
          "<cmd> Telescope help_tags <cr>",
          desc = "Find vim help tag",
        },
        ["<leader>fa"] = {
          "<cmd> Telescope builtin <cr>",
          desc = "All builtin funcs",
        },
      },
    },
    possession = {
      n = {
        ["<leader>se"] = {
          "<cmd>  Telescope possession list <cr>",
          desc = "Open Sessions",
        },
      },
    },
    dap = {
      n = {
        ["<F5>"] = {
          "<cmd> DapContinue <cr>",
          desc = "Start/Continue debugging",
        },
        ["<F10>"] = { "<cmd> DapStepOver <cr>", desc = "Step over" },
        ["<F11>"] = { "<cmd> DapStepInto <cr>", desc = "Step into" },
        ["<F12>"] = { "<cmd> DapStepOut <cr>", desc = "Step out" },

        ["<leader>dt"] = {
          function()
            require("dap").terminate()
            require("dapui").close()
          end,
          desc = "Terminate dap session",
        },

        ["<leader>bb"] = {
          "<cmd>  DapToggleBreakpoint <cr>",
          desc = "Toggle breakpoint",
        },
        ["<leader>bc"] = {
          function()
            require("dap").clear_breakpoints()
          end,
          desc = "Clear breakpoints",
        },
        ["<leader>bl"] = {
          "<cmd> Telescope dap list_breakpoints <cr>",
          desc = "List breakpoints",
        },

        ["<leader>dm"] = {
          "<cmd> Telescope dap commands <cr>",
          desc = "Show dap commands",
        },
        ["<leader>dc"] = {
          "<cmd> Telescope dap configurations <cr>",
          desc = "Show dap configurations",
        },
        ["<leader>dl"] = {
          "<cmd> Telescope dap variables <cr>",
          desc = "Show dap variables",
        },
        ["<leader>df"] = {
          "<cmd> Telescope dap frames <cr>",
          desc = "Show dap frames",
        },
      },
    },
  },
}

local M = {}

M.default_opts = { silent = true }
M.leader = " "

M.general = {
  n = {
    ["q"] = { "<cmd> bdelete <cr>", "Delete current buffer" },
    ["<S-l>"] = { "<cmd> bnext <cr>", "Next buf" },
    ["<S-h>"] = { "<cmd> bprevious <cr>", "Previous buf" },

    ["<C-h>"] = { "<C-w>h", "Cursor -> left side window" },
    ["<C-j>"] = { "<C-w>j", "Cursor -> lower window" },
    ["<C-k>"] = { "<C-w>k", "Cursor -> upper window" },
    ["<C-l>"] = { "<C-w>l", "Cursor -> right side window" },

    ["<leader>sj"] = { "<cmd> split <cr>", "Split window below" },
    ["<leader>sl"] = {
      "<cmd> vsplit <cr>",
      "Split window to the right",
    },

    ["<C-Up>"] = { "<cmd> resize -2 <cr>", "Resize win -y" },
    ["<C-Down>"] = { "<cmd> resize +2 <cr>", "Resize win +y" },
    ["<C-Left>"] = { "<cmd> vertical resize -2 <cr>", "Resize win -x" },
    ["<C-Right>"] = { "<cmd> vertical resize +2 <cr>", "Resize win +x" },
  },
}

M.lspconfig = {
  n = {
    ["gd"] = { "<cmd> Telescope lsp_definitions <cr>", "Definitions" },
    ["gi"] = { "<cmd> Telescope lsp_implementations <cr>", "Implementations" },
    ["gt"] = { "<cmd> Telescope lsp_type_definitions <cr>", "Type definitions" },
    ["gr"] = { "<cmd> Telescope lsp_references <cr>", "References" },
    ["gl"] = { vim.diagnostic.open_float, "Open diagnostic float window" },
    ["K"] = { vim.lsp.buf.hover, "Hover info" },
    ["<leader>di"] = { "<cmd> Telescope diagnostics <cr>", "See diagnostics" },
    ["<leader>fo"] = { vim.lsp.buf.format, "Format file" },
    ["<leader>ca"] = { vim.lsp.buf.code_action, "Code actions" },
    ["<leader>re"] = { vim.lsp.buf.rename, "Rename" },
    ["<leader>gn"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
    ["<leader>gp"] = { vim.diagnostic.goto_prev, "Go to prev diagnostic" },
  },
}

M.clangd = {
  n = {
    ["<leader>o"] = {
      "<cmd> ClangdSwitchSourceHeader <cr>",
      "Swap between header and source",
    },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = {
      "<cmd> NvimTreeToggle <cr>",
      "Toggle dir explorer",
    },
  },
}

M.toggleterm = {
  n = {
    ["<A-i>"] = {
      function()
        vim.cmd("ToggleTerm direction=horizontal name=toggle_terminal <cr>")
        vim.o.spell = false
      end,
      "Toggle terminal",
    },
  },
  t = {
    ["<A-i>"] = {
      "<cmd> ToggleTerm direction=horizontal name=toggle_terminal <cr>",
      "Toggle terminal",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>fi"] = {
      "<cmd> Telescope find_files <cr>",
      "Find file",
    },
    ["<leader>fs"] = {
      "<cmd> Telescope current_buffer_fuzzy_find <cr>",
      "Find in current buf",
    },
    ["<leader>fg"] = {
      "<cmd> Telescope live_grep <cr>",
      "Live grep",
    },
    ["<leader>fh"] = {
      "<cmd> Telescope help_tags <cr>",
      "Find vim help tag",
    },
    ["<leader>fa"] = {
      "<cmd> Telescope builtin <cr>",
      "All builtin funcs",
    },
  },
}

M.possession = {
  n = {
    ["<leader>se"] = {
      "<cmd> Telescope possession list <cr>",
      "Open Sessions",
    },
  },
}

M.dap = {
  n = {
    ["<F5>"] = {
      "<cmd> DapContinue <cr>",
      "Start/Continue debugging",
    },
    ["<F10>"] = { "<cmd> DapStepOver <cr>", "Step over" },
    ["<F11>"] = { "<cmd> DapStepInto <cr>", "Step into" },
    ["<F12>"] = { "<cmd> DapStepOut <cr>", "Step out" },

    ["<leader>dt"] = {
      function()
        require("dap").terminate()
        require("dapui").close()
      end,
      "Terminate dap session",
    },

    ["<leader>br"] = {
      "<cmd> DapToggleBreakpoint <cr>",
      "Toggle breakpoint",
    },
    ["<leader>bc"] = {
      function()
        require("dap").clear_breakpoints()
      end,
      "Clear breakpoints",
    },
    ["<leader>bl"] = {
      "<cmd> Telescope dap list_breakpoints <cr>",
      "List breakpoints",
    },

    ["<leader>dm"] = {
      "<cmd> Telescope dap commands <cr>",
      "Show jap commands",
    },
    ["<leader>dc"] = {
      "<cmd> Telescope dap configurations <cr>",
      "Show dap configurations",
    },
    ["<leader>jl"] = {
      "<cmd> Telescope dap variables <cr>",
      "Show dap variables",
    },
    ["<leader>df"] = {
      "<cmd> Telescope dap frames <cr>",
      "Show dap frames",
    },
  },
}

return M

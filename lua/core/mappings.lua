local M = {}

M.default_opts = { silent = true }
M.leader = " "

M.general = {
    i = {
        ["jk"] = { "<esc>", "Esc into normal mode" },
    },
    n = {
        -- Cursor jump between windows
        ["<C-h>"] = { "<C-w>h", "Cursor -> left side window" },
        ["<C-j>"] = { "<C-w>j", "Cursor -> lower window" },
        ["<C-k>"] = { "<C-w>k", "Cursor -> upper window" },
        ["<C-l>"] = { "<C-w>l", "Cursor -> right side window" },
        -- Create split windows
        ["<leader>sj"] = { "<cmd> split <cr>", "Split window below" },
        ["<leader>sl"] = { "<cmd> vsplit <cr>", "Split window to the right" },
        -- Resize Windows
        ["<C-Up>"] = { "<cmd> resize -2 <cr>", "Resize win -y" },
        ["<C-Down>"] = { "<cmd> resize +2 <cr>", "Resize win +y" },
        ["<C-Left>"] = { "<cmd> vertical resize -2 <cr>", "Resize win -x" },
        ["<C-Right>"] = { "<cmd> vertical resize +2 <cr>", "Resize win +x" },

        ["<C-q>"] = { "<cmd> quitall <cr>", "Quit neovim" },
    },
}

M.lsp = {
    i = {
        ["<C-h>"] = { vim.lsp.buf.signature_help, "Signature Help" },
    },
    n = {
        ["gd"] = { "<cmd> Telescope lsp_definitions <cr>", "Goto definitions" },
        ["gi"] = { "<cmd> Telescope lsp_implementations <cr>", "Goto implementations" },
        ["gt"] = { "<cmd> Telescope lsp_type_definitions <cr>", "Goto type definitions" },
        ["gr"] = { "<cmd> Telescope lsp_references <cr>", "List references" },
        ["gl"] = { vim.diagnostic.open_float, "Open diagnostics hover info" },
        ["K"] = { vim.lsp.buf.hover, "Open hover info" },
        ["<leader>di"] = { "<cmd> Telescope diagnostics <cr>", "See all diagnostics in buffer" },
        ["<leader>fo"] = { vim.lsp.buf.format, "Format file" },
        ["<leader>ca"] = { vim.lsp.buf.code_action, "Code actions" },
        ["<leader>re"] = { vim.lsp.buf.rename, "Rename" },
        ["<leader>gn"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
        ["<leader>gp"] = { vim.diagnostic.goto_prev, "Go to prev diagnostic" },
    },
}

M.nvimtree = {
    n = {
        ["<leader>e"] = { "<cmd> NvimTreeToggle <cr>", "Toggle dir explorer" },
    },
}

M.barbar = {
    n = {
        ["q"] = { "<cmd> BufferClose <cr>", "Close buffer" },
        ["<S-l>"] = { "<cmd> BufferNext <cr>", "Goto next buffer" },
        ["<S-h>"] = { "<cmd> BufferPrevious <cr>", "Goto previous buffer" },
        ["<A-l>"] = { "<cmd> BufferMoveNext <cr>", "Move buffer next" },
        ["<A-h>"] = { "<cmd> BufferMovePrevious <cr>", "Move buffer previous" },
    },
}

M.toggleterm = {
    n = {
        ["<A-i>"] = {
            function()
                vim.cmd("ToggleTerm")
                vim.o.spell = false
            end,
            "Toggle terminal",
        },
    },
    t = {
        ["<A-i>"] = {
            "<cmd> ToggleTerm <cr>",
            "Toggle terminal",
        },
    },
}

M.telescope = {
    n = {
        ["<leader>fi"] = { "<cmd> Telescope find_files <cr>", "Find file" },
        ["<leader>fl"] = {
            "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <cr>",
            "Find all",
        },
        ["<leader>fs"] = {
            "<cmd> Telescope current_buffer_fuzzy_find <cr>",
            "Find in current buf",
        },
        ["<leader>fg"] = { "<cmd> Telescope live_grep <cr>", "Live grep" },
        ["<leader>fh"] = { "<cmd> Telescope help_tags <cr>", "Find vim help tag" },
        ["<leader>fa"] = { "<cmd> Telescope builtin <cr>", "All builtin funcs" },
    },
}

M.dap = {
    n = {
        -- Control
        ["<F5>"] = {
            function()
                require("dap").continue()
                require("dapui").open()
            end,
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
        -- Breakpoints
        ["<leader>br"] = { "<cmd> DapToggleBreakpoint <cr>", "Toggle breakpoint" },
        ["<leader>bc"] = {
            function()
                require("dap").clear_breakpoints()
            end,
            "Clear breakpoints",
        },
        ["<leader>bl"] = { "<cmd> Telescope dap list_breakpoints <cr>", "List breakpoints" },
        -- Telescope dap menus
        ["<leader>dm"] = { "<cmd> Telescope dap commands <cr>", "Show jap commands" },
        ["<leader>dc"] = { "<cmd> Telescope dap configurations <cr>", "Show dap configurations" },
        ["<leader>jl"] = { "<cmd> Telescope dap variables <cr>", "Show dap variables" },
        ["<leader>df"] = { "<cmd> Telescope dap frames <cr>", "Show dap frames" },
    },
}

return M

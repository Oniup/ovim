return {
  "simrat39/rust-tools.nvim",
  ft = { ".rs" },
  config = function()
    local rust_tools = require("rust-tools")
    rust_tools.setup({
      tools = {
        inlay_hints = {
          auto = false,
          show_parameter_hints = false,
        }
      },
      server = {
        on_attach = function(_, bufnr)
          local opts = { buffer = bufnr, silent = true, noremap = true }

          -- Hover actions
          vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, opts)
          -- Code action groups
          vim.keymap.set(
            "n", "<leader>cg",
            rust_tools.code_action_group.code_action_group, opts)
        end
      }
    })

    -- Enables :RustRunnables
    require('rust-tools').runnables.runnables()
  end
}

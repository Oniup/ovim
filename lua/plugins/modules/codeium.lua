return {
  "Exafunction/codeium.vim",
  lazy = false,
  config = function()
    vim.g.codeium_disable_bindings = 1

    local opts = { silent = true, expr = true }
    vim.keymap.set("i", "<C-i>", function() return vim.fn["codeium#Accept"]() end, opts)
    vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, opts)
    vim.keymap.set("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, opts)
    vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"](-1) end, opts)
  end
}

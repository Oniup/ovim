return {
  "puremourning/vimspector",
  config = function()
    vim.g.vimspector_sidebar_width = 85
    vim.g.vimspector_bottombar_height = 15
    vim.g.vimspector_terminal_maxwidth = 70

    vim.keymap.set("n", "<F5>", "<cmd>call vimspector#Launch()<cr>", { noremap = true })
    vim.keymap.set("n", "<F8>", "<cmd>call vimspector#Reset()<cr>", { noremap = true })
    vim.keymap.set("n", "<F11>", "<cmd>call vimspector#StepOver()<cr>\")", { noremap = true })
    vim.keymap.set("n", "<F10>", "<cmd>call vimspector#StepInto()<cr>\")", { noremap = true })
    vim.keymap.set("n", "<F12>", "<cmd>call vimspector#StepOut()<cr>\")", { noremap = true })

    vim.keymap.set("n", "<leader>bb", ":call vimspector#ToggleBreakpoint()<cr>")
    vim.keymap.set("n", "<leader>bw", ":call vimspector#AddWatch()<cr>")
    vim.keymap.set("n", "<leader>be", ":call vimspector#Evaluate()<cr>")
  end
}

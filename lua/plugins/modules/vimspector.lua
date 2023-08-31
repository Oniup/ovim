return {
  "puremourning/vimspector",
  lazy = false,
  config = function()
    vim.g.vimspector_sidebar_width = 85
    vim.g.vimspector_bottombar_height = 15
    vim.g.vimspector_terminal_maxwidth = 70

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<F5>", "<cmd>call vimspector#Launch()<cr>", opts)
    vim.keymap.set("n", "<F8>", "<cmd>call vimspector#Reset()<cr>", opts)
    vim.keymap.set("n", "<F11>", "<cmd>call vimspector#StepOver()<cr>\")", opts)
    vim.keymap.set("n", "<F10>", "<cmd>call vimspector#StepInto()<cr>\")", opts)
    vim.keymap.set("n", "<F12>", "<cmd>call vimspector#StepOut()<cr>\")", opts)

    vim.keymap.set("n", "<leader>bb", ":call vimspector#ToggleBreakpoint()<cr>", opts)
    vim.keymap.set("n", "<leader>bw", ":call vimspector#AddWatch()<cr>", opts)
    vim.keymap.set("n", "<leader>be", ":call vimspector#Evaluate()<cr>", opts)

    vim.cmd([[
func! CustomiseUI()
      call win_gotoid(g:vimspector_session_windows.code)
      " Clear the existing WinBar created by Vimspector
      nunmenu WinBar
      " Create our own WinBar
      nnoremenu WinBar.■\ Stop :call vimspector#Stop( { 'interactive': v:false } )<CR>
      nnoremenu WinBar.▶\ Cont :call vimspector#Continue()<CR>
      nnoremenu WinBar.▷\ Pause :call vimspector#Pause()<CR>
      nnoremenu WinBar.↷\ Next :call vimspector#StepOver()<CR>
      nnoremenu WinBar.→\ Step :call vimspector#StepInto()<CR>
      nnoremenu WinBar.←\ Out :call vimspector#StepOut()<CR>
      nnoremenu WinBar.⟲: :call vimspector#Restart()<CR>
      nnoremenu WinBar.✕ :call vimspector#Reset( { 'interactive': v:false } )<CR>
      endfunction

      augroup MyVimspectorUICustomistaion
        autocmd!
        autocmd User VimspectorUICreated call s:CustomiseUI()
      augroup END
    ]])
  end
}

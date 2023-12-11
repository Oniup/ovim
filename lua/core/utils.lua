--- Useful lazy loading events
-------------------------------------------------------------------------------
--
-- * LazyDone**when lazy has finished starting up and loaded your config
-- * LazySync**after running sync
-- * LazyInstall**after an install
-- * LazyUpdate**after an update
-- * LazyClean**after a clean
-- * LazyCheck**after checking for updates
-- * LazyLog**after running log
-- * LazyLoad**after loading a plugin. The `data` attribute will contain the
--   plugin name.
-- * LazySyncPre**before running sync
-- * LazyInstallPre**before an install
-- * LazyUpdatePre**before an update
-- * LazyCleanPre**before a clean
-- * LazyCheckPre**before checking for updates
-- * LazyLogPre**before running log
-- * LazyReload**triggered by change detection after reloading plugin specs
-- * VeryLazy**triggered after `LazyDone` and processing `VimEnter` auto
--   commands
-- * LazyVimStarted**triggered after `UIEnter` when
--   `require("lazy").stats().startuptime` has been calculated.
--   Useful to update the startuptime on your dashboard.
--
--- Vim Event timeline
-------------------------------------------------------------------------------
--  BufWinEnter (create a default window)
--  BufEnter (create a default buffer)
--  VimEnter (start the Vim session):edit demo.txt
--  BufNew (create a new buffer to contain demo.txt)
--  BufAdd (add that new buffer to the session’s buffer list)
--  BufLeave (exit the default buffer)
--  BufWinLeave (exit the default window)
--  BufUnload (remove the default buffer from the buffer list)
--  BufDelete (deallocate the default buffer)
--  BufReadCmd (read the contexts of demo.txt into the new buffer)
--  BufEnter (activate the new buffer)
--  BufWinEnter (activate the new buffer's window)i
--  InsertEnter (swap into Insert mode)

local M = {}

M.autocmd_id_name = "OvimAutoCmdGroup"

M.autocmd_id = vim.api.nvim_create_augroup(
  M.autocmd_id_name, {
    clear = true
  })

M.icons = require("defaults.icons")

M.load_icons = function()
  local usr_icons_ok, usr_icons = pcall(require, "config.icons")
  if usr_icons_ok then
    M.icons = vim.tbl_deep_extend("force", M.icons, usr_icons)
  end
end

--- @brief Inserts term shell options for target shell. If no shell is given,
--- then will use defaults. However for windows, will prioritize using pwsh
--- over powershell unless specified
---
--- @param opts table Current options table
--- @param other_shell string|table|nil Target another shell
--- @return table opts Extended options table with terminal shell options
M.set_term_shell = function(opts, other_shell)
  local shell_opts = {}
  local other_shell_success = false

  if other_shell then
    --- TODO: ...
  end

  if not other_shell_success then
    if vim.fn.has("win32") then
      shell_opts = {
        shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command " ..
            "[Console]::InputEncoding=[Console]::OutputEncoding=" ..
            "[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }
    end
  end

  return vim.tbl_deep_extend("force", opts, shell_opts)
end


return M

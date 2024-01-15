local M = {}

local dap, dapui = require("dap"), require("dapui")
local u = require("core.utils")
local ui = u.ui

local function open_dapui()
  dapui.open()
end

local function close_dapui()
  dapui.close()
end

M.listeners = {
  before = {
    attach = open_dapui,
    launch = open_dapui,
    event_terminated = close_dapui,
    event_existed = close_dapui,
  },
}

M.opts = {
  layouts = ui.dapui.layouts,
  icons = ui.icons.dapui.expanding_controls,
  controls = ui.dapui.controls,
  floating = {
    border = ui.border.type,
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
}

function M.load_cmp_extension()
  local telescope = require("telescope")
  telescope.load_extension("dap")
  require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })
end

function M.loaded_callback(config)
  local listeners = config.listeners
  dap.listeners.before.attach.dapui_config = listeners.before.attach
  dap.listeners.before.launch.dapui_config = listeners.before.launch
  dap.listeners.before.event_exited.dapui_config = listeners.before.event_exited
  dap.listeners.before.event_terminated.dapui_config = listeners.before.event_terminated

  if config.load_cmp_extension then
    config.load_cmp_extension()
  end
end

return M

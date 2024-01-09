local M = {}

M.opts = {
  -- layouts = {
  --   {
  --     size = 40,
  --     position = "left",
  --     elements = {
  --       { id = "scopes", size = 0.25 },
  --       { id = "breakpoints", size = 0.25 },
  --       { id = "stacks", size = 0.25 },
  --       { id = "watches", size = 0.25 },
  --     },
  --   },
  --   {
  --     size = 10,
  --     position = "bottom",
  --     elements = {
  --       { id = "repl", size = 0.18 },
  --       { id = "console", size = 1.0 },
  --     },
  --   },
  -- },
}

function M.loaded_callback(config)
  local dap = require("dap")
  require("dapui").setup(config.opts.dapui)
  dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
  end
  local telescope = require("telescope")
  telescope.load_extension("dap")
  require("cmp").setup.filetype(
    { "dap-repl", "dapui_watches", "dapui_hover" },
    {
      sources = {
        { name = "dap" },
      },
    }
  )
end

return M

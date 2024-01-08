local u = require("core.utils")

local M = {}

M.adapters = {
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = u.os_correct_exec(
        u.mason_install_path .. "codelldb/extension/adapter/codelldb"
      ),
      args = {
        "--port",
        "${port}",
      },
      detached = false,
    },
  },
}

M.configurations = {
  c = {
    u.dap_config_template("codelldb", "C"),
  },
  cpp = {
    u.dap_config_template("codelldb", "C++"),
  },
  rust = {
    u.dap_config_template("codelldb", "Rust"),
  },
}

return M

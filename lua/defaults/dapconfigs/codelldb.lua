local utils = require("core.utils")

local M = {}

M.adapters = {
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = utils.get_mason_package("codelldb/extension/adapter/codelldb", true),
      args = {
        "--port", "${port}"
      },
      detached = false
    }
  }
}

M.configurations = {
  c = {
    utils.dapconfig_lang_template("codelldb", "C")
  },
  cpp = {
    utils.dapconfig_lang_template("codelldb", "C++")
  },
  rust = {
    utils.dapconfig_lang_template("codelldb", "Rust")
  },
}

return M

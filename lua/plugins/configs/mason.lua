local M = {}

local u = require("core.utils")

M.opts = {
  ensure_installed = {
    -- Language servers
    "lua-language-server",
    "vim-language-server",
    "json-lsp",
    "misspell",

    -- Formatters and linters
    "stylua",
  },
  mason = {
    ui = {
      icons = u.icons.mason,
      border = u.icons.border,
    },
  },
 --  mason_tools = {
 --    auto_update = true,
 --    run_on_start = true, -- Automatically install / update on startup.
 --    start_delay = 3000, -- Set a delay (in ms) before the installation starts
 --    debounce_hours = 5, -- Set to 0 if run_on_start == false
 --  },
}

function M.setup(lazy_plugin, opts)
  require("mason").setup(opts.mason)
  local registry = require("mason-registry")

  vim.g.mason_installed_list = registry.get_installed_package_names()

  if opts.ensure_installed then
    for _, client in ipairs(opts.ensure_installed) do
      if not vim.tbl_contains(vim.g.mason_installed_list, client) then
        vim.cmd("MasonInstall " .. client)
        table.insert(vim.g.mason_installed_list, client)
      end
    end
  end
end

return M

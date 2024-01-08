local M = {}

local ui = require("core.utils").ui

M.opts = {
  ensure_installed = {
    "lua-language-server",
    "vim-language-server",
    "json-lsp",

    "stylua",
  },
  mason = {
    ui = {
      icons = ui.icons.mason,
      border = ui.border.type,
      width = 0.6,
      height = 0.6,
    },
  },
}

function M.setup(_, opts)
  require("mason").setup(opts.mason)
  require("mason-lspconfig").setup()

  local registry = require("mason-registry")
  registry.update()

  if opts.ensure_installed then
    local installed_list = registry.get_installed_package_names()

    for _, client in ipairs(opts.ensure_installed) do
      if not vim.tbl_contains(installed_list, client) then
        vim.cmd("MasonInstall " .. client)
        table.insert(installed_list, client)
      end
    end
  end
end

return M

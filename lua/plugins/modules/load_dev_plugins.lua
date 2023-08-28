local folder_exists, plugins = pcall(require, "plugins.dev_plugins")

if folder_exists then
  vim.notify("Loaded dev plugins ...")
  return require("plugins.dev_plugins")
else
  vim.notify("No dev plugins loaded")
  return {}
end

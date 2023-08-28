local folder_exists, plugins = pcall(require, "plugins.dev_plugins")

if folder_exists then
  vim.notify("Loaded dev plugins")
  return plugins
else
  return {}
end

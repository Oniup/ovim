return {
  "folke/neodev.nvim",
  dependencies = {
    "folke/neoconf.nvim",
  },
  opts = {
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true
    },
    lspconfig = true,
    pathStrict = true
  }
}

return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    local icons = require("core.utils").icons

    require("gitsigns").setup({
      signs = icons.gitsigns,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
      },
    })
  end
}

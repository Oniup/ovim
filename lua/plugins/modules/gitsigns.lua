return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        -- changedelete = { text = '~' },
        changedelete = { text = '│' },
        untracked    = { text = '│' },
      },
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
      },
    })
  end
}

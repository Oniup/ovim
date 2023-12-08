local usr_ok, usr_colorscheme = pcall(require, "config.colorscheme")

return {
  "Oniup/ignite.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local name = "ignite"

    if usr_ok then
      name = usr_colorscheme.name
      if usr_colorscheme.setup ~= nil then
        usr_colorscheme.setup()
      end
    else
      require("ignite").setup()
    end

    vim.cmd.colorscheme(name)
  end
}

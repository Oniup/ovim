local ovim_opts = require("core.options")
local ovim_keymaps = require("core.keymaps")
local ovim_utils = require("core.utils")

ovim_opts.load_opts()
ovim_keymaps.load_keymaps()
ovim_utils.load_icons()

local usr_ok, usr_init = pcall(require, "config")
if usr_ok then
  usr_init.on_startup()
end

local plugins = require("core.plugins")
plugins.load_plugins()
-- ovim_keymaps.plugin_keymaps_autocmd_setup()

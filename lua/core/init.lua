local keymaps = require("core.keymaps")
local opts = require("core.options")
local utils = require("core.utils")

opts.load_opts()
utils.load_icons()
keymaps.load_keymaps()

local usr_init = utils.prequire("config")
if usr_init then
  usr_init.on_startup()
end

local plugins = require("core.plugins")
plugins.load_plugins()

-- Remove required initializing tables
keymaps.plugin_keymaps = nil
keymaps.mapping_modes = nil
keymaps.default_opts = nil

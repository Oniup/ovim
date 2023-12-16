local keymaps = require("core.keymaps")
local opts = require("core.options")
local utils = require("core.utils")

utils.prequire("config")
opts.load_opts()
utils.load_icons()
keymaps.load_keymaps()


local plugins = require("core.plugins")
plugins.load_plugins()

-- Remove required initializing tables
keymaps.plugin_keymaps = nil
keymaps.mapping_modes = nil
keymaps.default_opts = nil

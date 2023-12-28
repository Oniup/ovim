local keymaps = require("core.keymaps")
local opts = require("core.options")
local utils = require("core.utils")

opts.load_opts()
utils.load_icons()
keymaps.load_keymaps()

local plugins = require("core.plugins")
plugins.load_plugins()

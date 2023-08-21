local keyset = vim.keymap.set

-- function get_buffer_filetype()
-- 	local buffer_name = vim.api.nvim_buf_get_name(0)
-- 	local offset = (buffer_name:reverse()):find("%.") - 1
-- 	return buffer_name:sub(#buffer_name - offset)
-- end
-- 
-- function get_buffer_filename()
-- 	local buffer_name = vim.api.nvim_buf_get_name(0)
-- 	local offset = (buffer_name:reverse()):find("%/")
-- 	if offset == nil then
-- 		offset = (buffer_name:reverse()):find("%\\")
-- 		if offset == nil then
-- 			return buffer_name
-- 		end
-- 	end
-- 	return buffer_name:sub(#buffer_name - offset + 2)
-- end
-- 
-- function run_if_buf_is(allowed, fn)
-- 	local buffer_filetype = get_buffer_filetype()
-- 	for i = 1, #allowed.filetypes do 
-- 		if allowed.filetypes[i] == buffer_filetype then
-- 			fn()
-- 			return
-- 		end
-- 	end
-- 
-- 	local buffer_filename = get_buffer_filename()
-- 	for i = 1, #allowed.filenames do
-- 		if allowed.filenames[i] == buffer_filename then
-- 			fn()
-- 			return 
-- 		end
-- 	end
-- end

-- local allow_in_files_of = function(ft_allowed, func)
-- 	-- Check filetypes
-- 	local buf_ft = get_current_buffer_filetype()
-- 	for i = 0, #ft_allowed.filetypes do
-- 		if ft_allowed.filetypes[i] == buf_ft then
-- 			func()
-- 		end
-- 	end
-- 
-- 	-- Check filenames
-- 	local buf_name = vim.api.nvim_buf_get_name(0)
-- 	for i = 0, #ft.allowed.filenames do
-- 		if ft_allowed.filenames[i] == buf_name then
-- 			func()
-- 		end
-- 	end
-- end

----------------------- Color scheme -----------------------
vim.o.background = "dark"
vim.cmd("syntax enable")
vim.cmd("colorscheme gruvbox")


--------------------------- COC ----------------------------
local coc_opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
local coc_silent = { silent = true }

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Use tab for completion
keyset("i", "<TAB>", "coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? '<TAB>' : coc#refresh()", coc_opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], coc_opts)

-- <CR> to accept selected completion item
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], coc_opts)

-- GOTO code navigation
keyset("n", "gd", "<Plug>(coc-definition)", coc_silent)
keyset("n", "gy", "<Plug>(coc-type-definition)", coc_silent)
keyset("n", "gi", "<Plug>(coc-implementation)", coc_silent)
keyset("n", "gr", "<Plug>(coc-references)", coc_silent)
keyset("n", "<leader>re", "<Plug>(coc-rename)", coc_silent)

vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
keyset("n", "<leader>fo", ":Format<CR>", coc_opts)

-- Language specific
keyset("n", "<leader>o", ":CocCommand clangd.switchSourceHeader vsplit<CR>", {})
keyset("n", "<leader>sy", ":CocCommand clangd.symbolInfo<CR>", {})


----------------------- Tree sitter -----------------------
require("nvim-treesitter.configs").setup{
	highlight = {
		enable = true
	}
}


------------------------ Telescope ------------------------
local telescope  = require("telescope")
local telescope_actions = require("telescope.actions")
telescope.setup({
	defaults = {
		border = true,
		mappings = {
			i = { ["qq"] = telescope_actions.close },
			n = { ["qq"] = telescope_actions.close },
		},
		layout_strategy = "horizontal",
    layout_config = {
        height = 40,
        width = 160,
        preview_width = 100,
        prompt_position = "top"
    },
		path_display = {
			shorten = 3,
		},
    sorting_strategy = "ascending",
	}
})
-- telescope.load_extension("fzf")
telescope.load_extension("cmake4vim")

local tel_opts = { noremap = true }
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
keyset("n", "<leader>ff", telescope_builtin.find_files, tel_opts)
keyset("n", "<leader>fg", telescope_builtin.live_grep, tel_opts)
keyset("n", "<leader>fb", telescope_builtin.buffers, tel_opts)
keyset("n", "<leader>fh", telescope_builtin.help_tags, tel_opts)


-------------------------- CMake --------------------------
local cmake_targets = {
	filetypes = { ".cpp", ".c" },
	filenames = { "CMakeLists.txt" }
}

vim.api.nvim_create_user_command("GenCMake", ":CMake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=On", {})

keyset("n", "<leader>lk", function() 
	allow_in_files_of(cmake_targets, function() 
		telescope.extensions.cmake4vim.select_kit(telescope_themes.get_dropdown({})) 
	end) 
end, { silent = true, noremap = true })


------------------------- Lua line --------------------------
require("lualine").setup({
	options = {
    component_separators = { right = "", left = ""},
    section_separators = { right = "", left = ""},
	}
})


----------------------- Buffer Line -----------------------
require("bufferline").setup{}


------------------------ Nvim Tree ------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

keyset("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })

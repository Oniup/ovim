local M = {}

local ui = require("core.utils").ui
local actions = require("telescope.actions")

M.enable_preview = {
    preview = true,
    preview_cutoff = 1, -- Preview should always show (unless previewer = false)
    layout_strategy = "horizontal",
    layout_config = {
        width = 0.80,
        preview_width = 0.50,
    },
}

M.extension_list = {
    "ui-select",
}

M.opts = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        initial_mode = "insert",
        selection_strategy = "reset",
        prompt_prefix = " " .. ui.icons.noice.cmdline.search .. "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        border = ui.border.type ~= "none",
        borderchars = ui.border.telescope[ui.border.type],
        sorting_strategy = "ascending",
        preview = false,
        results_title = false,
        layout_strategy = "center",
        layout_config = {
            prompt_position = "top",
            anchor = "N",
            width = 0.40,
            height = 0.50,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        path_display = { "truncate" },
        file_ignore_patterns = {
            "node_modules",
            "zig-cache",
            "zig-out",
            "spell",

            "%.png",
            "%.jpg",
            "%.bitmap",
            "%.zip",
        },
        mappings = {
            n = {
                ["q"] = actions.close,
            },
        },
    },
    pickers = {
        current_buffer_fuzzy_find = M.enable_preview,
        live_grep = M.enable_preview,
        help_tags = M.enable_preview,
    },
}

function M.loaded_callback(config)
    for _, ext in ipairs(config.extension_list) do
        require("telescope").load_extension(ext)
    end
end

return M

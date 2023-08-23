----------------------- Tree sitter -----------------------
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c", "cpp", "c_sharp", "python", "lua", "vimdoc", "vim", "json", "yaml",
    "rust", "toml"
  },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true },
}


------------------------ Telescope ------------------------
local telescope         = require("telescope")
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
    sorting_strategy = "ascending",
  }
})

local tel_opts = { noremap = true }
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, tel_opts)
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, tel_opts)
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, tel_opts)
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, tel_opts)


------------------------ Nvim Tree ------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sync_root_with_cwd = false,
  respect_buf_cwd = false,
  update_focused_file = {
    enable = true,
    update_root = false
  },
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })


--------------------- Project Manager ---------------------
require("project_nvim").setup({
  manual_mode = true,
})
telescope.load_extension("projects")

vim.api.nvim_create_user_command("OpenProject", function()
  telescope.extensions.projects.projects(telescope_themes.get_dropdown({}))
end, {})


----------------------- Comments --------------------------
require("Comment").setup()


-------------------- Toggle Terminal ----------------------
local terminal = require("buffer-term")
terminal.setup()

vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true })

vim.keymap.set("n", "<A-i>", function() terminal.toggle("a") end,
  { noremap = true, silent = true })
vim.keymap.set("t", "<A-i>", function() terminal.toggle("a") end, { noremap = true, silent = true })

local disable_spellcheck_in_terminal = vim.api.nvim_create_augroup("disable_spellcheck_in_terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embedded terminal
  command = "setlocal nospell",
  group = disable_spellcheck_in_terminal,
})

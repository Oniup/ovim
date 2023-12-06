--- User defined keymaps that will override the defaults if there is any overlap.
--- Here is an example:

return {
  leader = " ",
  n = {
    ["<leader>sj"] = { ":split<CR>", "Split window below" },
    ["<leader>sl"] = { ":vsplit<CR>", "Split window to the right" },
  },
  i = {
    ["jk"] = {
      "<esc>", "Escape from insert mode back into normal", { noremap = true } },
  },
  --- Only loads when extension is loaded
  ["telescope.nvim"] = {
    n = {
      ["<leader>ff>"] = {
        function() print("calls function") end, "Fuzzy file finder" },
    },
  },
}

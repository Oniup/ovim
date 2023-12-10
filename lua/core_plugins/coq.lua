vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    buffers = {
      always_on_top = false,
      enabled = true,
      match_syms = false,
      parent_scope = " ⇊",
      same_filetype = false,
      short_name = "BUF",
      weight_adjust = 0,
    },
    tree_sitter = {
      always_on_top = false,
      enabled = true,
      path_sep = " ⇊",
      short_name = "TS",
      slow_threshold = 0.168,
      weight_adjust = 0.1,
    },
  },
  keymap = {
    bigger_preview = "<c-Q>",
    eval_snips = nil,
    jump_to_mark = "<c-W>",
    manual_complete = "<c-space>",
    manual_complete_insertion_only = false,
    pre_select = false,
    recommended = true,
    ["repeat"] = nil,
  },
  completion = {
    always = true,
    replace_prefix_threshold = 3,
    replace_suffix_threshold = 2,
    skip_after = {},
    smart = true,
  },
  display = {
    icons = {
      aliases = {
        Conditional = "Keyword",
        Float = "Number",
        Include = "Property",
        Label = "Keyword",
        Member = "Property",
        Repeat = "Keyword",
        Structure = "Struct",
        Type = "TypeParameter",
      },
      mappings = require("core.utils").icons.kind,
    },
  },
}

return {
  "ms-jpq/coq_nvim",
  dependencies = {
    { "ms-jpq/coq.artifacts",  branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" }
  },
  config = function()
    require("coq")
  end
}

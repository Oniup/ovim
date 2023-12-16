local M = {}

local icons = require("core.utils").icons

M.plugin = {
  "ms-jpq/coq_nvim",
  branch = "coq",
  dependencies = {
    { "ms-jpq/coq.artifacts",  branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" }
  },
  opts = {
    auto_start = true,
    clients = {
      buffers = {
        always_on_top = false,
        enabled = true,
        match_syms = false,
        parent_scope = " ⇊",
        same_filetype = false,
        short_name = "buf",
        weight_adjust = 0,
      },
      lsp = {
        always_on_top = nil,
        enabled = true,
        resolve_timeout = 0.06,
        short_name = "lsp",
        weight_adjust = 0.5,
      },
      paths = {
        always_on_top = false,
        enabled = true,
        path_seps = {},
        preview_lines = 6,
        resolution = { "cwd", "file" },
        short_name = "path",
        weight_adjust = 0,
      },
      registers = {
        always_on_top = false,
        enabled = true,
        lines = {},
        match_syms = false,
        max_yank_size = 8888,
        register_scope = " ⇉ ",
        short_name = "reg",
        weight_adjust = 0,
        words = { "0" },
      },
      snippets = {
        always_on_top = false,
        enabled = true,
        short_name = "snip",
        user_path = nil,
        warn = { "missing", "outdated" },
        weight_adjust = 0.1,
      },
      tabnine = {
        always_on_top = false,
        enabled = false,
        short_name = "t9",
        weight_adjust = -0.1,
      },
      tags = {
        always_on_top = false,
        enabled = true,
        parent_scope = " ⇊",
        path_sep = " ⇉ ",
        short_name = "tag",
        weight_adjust = 0.1,
      },
      third_party = {
        always_on_top = nil,
        enabled = true,
        short_name = "3p",
        weight_adjust = 0,
      },
      tmux = {
        all_sessions = false,
        always_on_top = false,
        enabled = false,
        match_syms = false,
        parent_scope = " ⇊",
        path_sep = " ⇉ ",
        short_name = "tmux",
        weight_adjust = -0.1,
      },
      tree_sitter = {
        always_on_top = false,
        enabled = true,
        path_sep = " ⇊",
        short_name = "",
        slow_threshold = 0.168,
        weight_adjust = 0.1,
      },
    },
    keymap = {
      bigger_preview = "",
      eval_snips = nil,
      jump_to_mark = "",
      manual_complete = "<c-space>",
      manual_complete_insertion_only = false,
      pre_select = false,
      recommended = true,
      ["repeat"] = nil,
    },
    completion = {
      always = true,
      replace_prefix_threshold = 0,
      replace_suffix_threshold = 0,
      skip_after = {},
      smart = true,
    },
    display = {
      ghost_text = {
        context = { " [", "] " },
        enabled = true,
        highlight_group = "Comment",
      },
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
        mappings = icons.kind,
        mode = "short",
        spacing = 1,
      },
      mark_highlight_group = "Pmenu",
      preview = {
        border = icons.border,
        enabled = true,
        positions = {
          east = 4,
          north = 1,
          south = 2,
          west = 3,
        },
        resolve_timeout = 0.09,
        x_max_len = 88,
      },
      pum = {
        ellipsis = "...",
        fast_close = true,
        kind_context = { "", "" },
        source_context = { "", "" },
        x_max_len = 66,
        x_truncate_len = 12,
        y_max_len = 16,
        y_ratio = 0.3,
      },
      time_fmt = "%d.%m.%Y %H:%M",
      statusline = {
        helo = false
      },
    },
    limits = {
      completion_auto_timeout = 0.088,
      completion_manual_timeout = 0.66,
      download_retries = 6,
      download_timeout = 66.0,
      idle_timeout = 1.88,
      tokenization_limit = 999,
    },
    match = {
      exact_matches = 2,
      fuzzy_cutoff = 0.6,
      look_ahead = 2,
      max_results = 33,
      unifying_chars = { "_", "-" },
    },
    weights = {
      edit_distance = 1.5,
      prefix_matches = 2.0,
      proximity = 0.5,
      recency = 1.0,
    },
    xdg = false,
  },
  config = function()
    require("coq")
  end
}

M.before_loading = function()
  vim.g.coq_settings = M.plugin.opts
end

return M

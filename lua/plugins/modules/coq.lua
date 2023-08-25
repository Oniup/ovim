return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  dependencies = {
    { "ms-jpq/coq.artifacts",  branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  priority = 1000,
  config = function()
    local coq_settings = {
      display = {
        statusline = {
          helo = false
        },
        ghost_text = {
          enabled = false
        },
        pum = {
          source_context = { "", "" },
          kind_context = { " ", "" }
        },
        icons = {
          mode = "short",
        },
        preview = {
          border = "solid"
        },
        mark_highlight_group = "NormalFloat"
      },
      keymap = {
        jump_to_mark = ""
      }
    }
    vim.api.nvim_set_var("coq_settings", coq_settings)
    require("coq_3p")({
      { src = "nvimlua", short_name = "nLUA", conf_only = false },
    })
  end,
}

local M = {}

local ui = require("core.utils").ui

M.opts = {
  spinner = ui.icons.spinner,
  decay = 3000,
  series_format = function(title, message, percentage, done)
    local fmt = {}
    local has_title = false
    local has_msg = true
    if type(title) == "string" and string.len(title) > 0 then
      table.insert(fmt, title)
      has_title = true
    end
    if type(message) == "string" and string.len(message) > 0 then
      table.insert(fmt, message)
      has_msg = true
    end
    if percentage and (has_msg or has_title) then
      table.insert(fmt, string.format("%.0f%%%%", percentage))
    end
    return { msg = table.concat(fmt, " "), done = done }
  end,
  client_format = function(client_name, spinner, series_messages)
    if #series_messages == 0 then
      return nil
    end
    local msgs = {}
    local done = true
    for _, msg in ipairs(series_messages) do
      if not msg.done then
        done = false
      end
      table.insert(msgs, msg.msg)
    end
    local prefix = done and ui.icons.done or spinner
    return {
      name = client_name,
      body = prefix .. " " .. table.concat(msgs, ", "),
    }
  end,
  format = function(client_messages)
    local fmt_tbl = {}
    local msgs = {}
    for _, cli_msg in ipairs(client_messages) do
      if #cli_msg.body > 0 then
        msgs[cli_msg.name] =
          string.format("%s => %s", cli_msg.name, cli_msg.body)
      end
    end
    for _, cli in ipairs(vim.lsp.get_active_clients()) do
      if msgs[cli.name] then
        table.insert(fmt_tbl, msgs[cli.name])
      end
    end
    return table.concat(fmt_tbl, " | ")
  end,
}

return M

local M = {}

function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or M.parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or M.parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

function M.parse_hex(int_color)
  return string.format("#%x", int_color)
end

function M.get_buffer_count()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.bo[buf].buftype ~= "nofile" then
      count = count + 1
    end
  end
  return count
end

function M.get_venv()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv ~= nil and string.find(venv, "/") then
    local orig_venv = venv
    for w in orig_venv:gmatch("([^/]+)") do
      venv = w
    end
    venv = string.format("%s", venv)
  end
  return venv
end

M.filetype_map = {
  minifiles = { name = "minifiles", icon = "🗂️ " },
  snacks_picker_input = { name = "picker", icon = "🔍" },
  ["copilot-chat"] = { name = "copilot", icon = "🤖" },
  ["codecompanion"] = { name = "ai", icon = "🤖" },
}

return M

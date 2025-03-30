local M = {}
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or parse_hex(group.bg),
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

return M

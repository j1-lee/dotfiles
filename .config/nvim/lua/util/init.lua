local util = {}

function util.remove_trailing_spaces()
  if not vim.bo.modifiable then return end
  local lines = vim.fn.getline(1, '$')
  for i, line in ipairs(lines) do
    lines[i] = line:gsub('%s+$', '')
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

function util.last_position_jump()
  local pos = vim.api.nvim_buf_get_mark(0, '"')
  if pos[1] > 0 and pos[1] <= vim.fn.line('$') then
    vim.api.nvim_win_set_cursor(0, pos)
  end
end

function util.open_terminal(command, append_filename)
  command = command or "bash"
  if append_filename then
    command = command .. " " .. vim.fn.shellescape(vim.fn.expand '%')
  end
  vim.cmd.split("term://" .. command)
  vim.cmd.startinsert()
end

util.toggle = require 'util.toggle'

return util

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

function util.show_hlgroup()
  local synid = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
  if synid == 0 then return end
  local synname = vim.fn.synIDattr(synid, 'name')
  local syntrns = vim.fn.synIDattr(vim.fn.synIDtrans(synid), 'name')
  print(synname .. ' -> ' .. syntrns)
end

util.toggle = require 'util.toggle'

return util

local util = {}

function util.remove_trailing_spaces()
  if not vim.bo.modifiable then return end

  local lines = vim.fn.getline(1, '$')
  local modified = false

  for i, line in ipairs(lines) do
    local count
    lines[i], count = line:gsub('%s+$', '')
    modified = modified or count > 0
  end

  if modified then
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
  end
end

local function toggle_window(opener, finder, closer)
  local wins = vim.api.nvim_tabpage_list_wins(0)

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    if finder(buf) then
      if #wins == 1 then vim.cmd [[enew]] else closer(win) end
      return
    end
  end

  opener()
end

function util.toggle_vimrc()
  toggle_window (
    function() vim.cmd [[vsplit $MYVIMRC]] end,
    function(buf) return vim.api.nvim_buf_get_name(buf) == vim.env.MYVIMRC end,
    function(win) vim.api.nvim_win_close(win, false) end
  )
end

function util.toggle_quickfix()
  toggle_window (
    function() vim.cmd [[copen]] end,
    function(buf) return vim.bo[buf].buftype == 'quickfix' end,
    function() vim.cmd [[cclose]] end
  )
end

return util

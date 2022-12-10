local toggle = {}

local function toggle_window(finder, opener, closer)
  closer = closer or function(win) vim.api.nvim_win_close(win, false) end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if finder(buf) then
      if vim.fn.winnr '$' == 1 then vim.cmd.enew() else pcall(closer, win) end
      return
    end
  end

  pcall(opener)
end

function toggle.vimrc()
  toggle_window(
    function(buf) return vim.fn.bufname(buf) == vim.env.MYVIMRC end,
    function() vim.cmd.vsplit '$MYVIMRC' end
  )
end

function toggle.quickfix()
  toggle_window(
    function(buf) return vim.bo[buf].buftype == 'quickfix' end,
    vim.cmd.copen
  )
end

function toggle.mru()
  local mru = require 'util.mru'
  toggle_window(
    mru.is_mru,
    function() vim.cmd "10 split"; mru.show() end
  )
end

return toggle

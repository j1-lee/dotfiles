local toggle = {}

local function toggle_window(opener, closer, finder)
  local wins = vim.api.nvim_tabpage_list_wins(0)

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    if finder(buf) then
      if #wins == 1 then vim.cmd.enew() else pcall(closer, win) end
      return
    end
  end

  pcall(opener)
end

function toggle.vimrc()
  toggle_window(
    function() vim.cmd.vsplit '$MYVIMRC' end,
    function(win) vim.api.nvim_win_close(win, false) end,
    function(buf) return vim.fn.bufname(buf) == vim.env.MYVIMRC end
  )
end

function toggle.quickfix()
  toggle_window(
    function() vim.cmd.copen() end,
    function() vim.cmd.cclose() end,
    function(buf) return vim.bo[buf].buftype == 'quickfix' end
  )
end

function toggle.mru()
  local mru = require 'util.mru'
  toggle_window(
    function() vim.cmd "10 split"; mru.show() end,
    function(win) vim.api.nvim_win_close(win, false) end,
    mru.is_mru
  )
end

return toggle

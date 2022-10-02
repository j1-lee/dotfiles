vim.keymap.set('n', '<F5>', function()
  vim.cmd [[
    execute 'split term://python' shellescape(expand('%'))
    startinsert
  ]]
end, {buffer = 0})

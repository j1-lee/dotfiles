local augroup = vim.api.nvim_create_augroup('init_lua', {clear = true})

local function autocmd(event, opts)
  opts.group = augroup
  vim.api.nvim_create_autocmd(event, opts)
end

autocmd('FileType', {command = [[setlocal formatoptions=jq]]})

autocmd('FileType', {
  pattern = {'python', 'sh', 'vim', 'matlab', 'lua'},
  command = [[setlocal colorcolumn=81,82]]
})

autocmd('WinEnter', {command = [[set cursorline]]})
autocmd('WinLeave', {command = [[set nocursorline]]})

autocmd('BufReadPost', {
  callback = function()
    local pos = vim.api.nvim_buf_get_mark(0, '"')
    if pos[1] > 0 and pos[1] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, pos)
    end
  end
})

autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = [[source <afile> | PackerCompile]]
})

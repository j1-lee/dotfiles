local util = require 'util'

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

autocmd('BufReadPost', {callback = util.last_position_jump})

autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = [[source <afile> | PackerCompile]]
})

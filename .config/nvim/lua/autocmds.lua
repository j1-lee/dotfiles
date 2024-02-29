local util = require 'util'

local augroup = vim.api.nvim_create_augroup('init_lua', { clear = true })
local function autocmd(event, opts)
  opts.group = augroup
  vim.api.nvim_create_autocmd(event, opts)
end

autocmd('FileType', {
  callback = function() vim.opt_local.formatoptions = 'jq' end
})

autocmd('FileType', {
  pattern = { 'python', 'sh', 'vim', 'matlab', 'lua' },
  callback = function() vim.opt_local.colorcolumn = { 81, 82 } end
})

autocmd('FileType', {
  pattern = { 'tex', 'wiki' },
  callback = function() vim.opt_local.linebreak = true end
})

autocmd('WinEnter', { callback = function() vim.opt.cursorline = true end })
autocmd('WinLeave', { callback = function() vim.opt.cursorline = false end })

autocmd('BufReadPost', { callback = util.last_position_jump })

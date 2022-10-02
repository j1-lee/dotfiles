vim.opt_local.spell = true
vim.opt_local.spelllang:append {'es', 'cjk'}

local function add_tilde()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')

  local char = vim.fn.tr(line:sub(col, col), 'aeiounAEIOUN?!', 'áéíóúñÁÉÍÓÚÑ¿¡')

  line = line:sub(1, col - 1) .. char .. line:sub(col + 1, -1)
  vim.fn.setline('.', line)
end

vim.keymap.set('n', '_', add_tilde, {buffer = 0})

vim.api.nvim_create_autocmd('BufWritePost', {
  command = [[MakiExportHtml]],
  buffer = 0
})

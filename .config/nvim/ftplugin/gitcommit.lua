vim.opt_local.colorcolumn = { 73, 74 }

local types = {
  { 'feat',     "A new feature" },
  { 'fix',      "A bug fix" },
  { 'docs',     "Documentation only changes" },
  { 'style',    "Changes that do not affect the meaning of the code" },
  { 'refactor', "A code change that neither fixes a bug nor adds a feature" },
  { 'perf',     "A code change that improves performance" },
  { 'test',     "Adding missing tests or correcting existing tests" },
  { 'chore',    "Other changes that do not modify src or test files" },
  { 'revert',   "Reverts a previous commit" },
}

local function select_type()
  vim.ui.select(types, {
    format_item = function(item)
      return string.format('%-8s %s', unpack(item))
    end
  }, function(choice)
    if choice then
      vim.fn.setline('.', choice[1] .. ': ')
    end
    vim.v.char = 1
    vim.cmd.startinsert { bang = true }
  end)
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  command = [[call cursor(1, 0) | startinsert!]],
  buffer = 0
})

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    if vim.fn.line('.') == 1 and vim.fn.getline('.') == "" then
      select_type()
    end
  end,
  buffer = 0
})

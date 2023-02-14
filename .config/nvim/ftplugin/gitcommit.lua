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

local function insert_type()
  vim.ui.select(types, {
    format_item = function(item)
      return string.format('%-8s %s', item[1], item[2])
    end
  }, function(choice)
    if choice then
      vim.fn.append(0, choice[1] .. ': ')
      vim.fn.cursor(1, vim.fn.getline(1):len())
    end
  end)
end

vim.keymap.set('n', '<Leader><Leader>', insert_type)

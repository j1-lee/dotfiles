vim.opt_local.spell = true

require('nvim-surround').buffer_setup {
  surrounds = {
    ['"'] = { add = { "``", "''" } },
    ["'"] = { add = { "`", "'" } },
  }
}

vim.opt_local.colorcolumn = { 121, 122 }

vim.keymap.set('n', 'K', "<Cmd>call RAction('help')<CR>", { buffer = true })

vim.keymap.set('n', ']]', "<Cmd>call b:NextRChunk()<CR>", { buffer = true })
vim.keymap.set('n', '[[', "<Cmd>call b:PreviousRChunk()<CR>", { buffer = true })

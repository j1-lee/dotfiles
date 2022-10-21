local util = require 'util'

-- re-indenting keeps visual selection
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

-- resize window
vim.keymap.set('n', '<M-j>', "<Cmd>resize -4<CR>")
vim.keymap.set('n', '<M-k>', "<Cmd>resize +4<CR>")
vim.keymap.set('n', '<M-h>', "<Cmd>vertical resize -4<CR>")
vim.keymap.set('n', '<M-l>', "<Cmd>vertical resize +4<CR>")

vim.keymap.set('n', '<Space>', "<Cmd>nohlsearch<CR>")

-- move by display lines
vim.keymap.set('n', 'j', "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set('n', 'k', "v:count ? 'k' : 'gk'", { expr = true })

-- move between windows
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- manipulate tabs
vim.keymap.set('n', '<Leader>tn', "<Cmd>tabnew<CR>")
vim.keymap.set('n', '<Leader>tt', '<C-w>T') -- move window to a new tab

vim.keymap.set('n', 'x', '"_x') -- x does not use register

-- toggle windows
vim.keymap.set('n', '<Leader>f', "<Cmd>Lexplore!<CR>")
vim.keymap.set('n', '<Leader>c', util.toggle.vimrc)
vim.keymap.set('n', '<Leader>q', util.toggle.quickfix)

-- autocorrect last spell error
vim.keymap.set('i', '<C-s>', "<C-g>u<Esc>[S1z=`]a<C-g>u")
vim.keymap.set('n', '<C-s>', "[S1z=")

-- show highlight group at current position
vim.keymap.set('n', '<F10>', util.show_hlgroup)

-- remove trailing whitespaces
vim.keymap.set('n', '<F12>', util.remove_trailing_spaces)

local util = require 'util' -- util/init.lua

local function nmap(...) vim.keymap.set('n', ...) end
local function imap(...) vim.keymap.set('i', ...) end
local function xmap(...) vim.keymap.set('x', ...) end

-- re-indenting keeps visual selection
xmap('>', '>gv')
xmap('<', '<gv')

-- resize window
nmap('<M-j>', "<Cmd>resize -4<CR>")
nmap('<M-k>', "<Cmd>resize +4<CR>")
nmap('<M-h>', "<Cmd>vertical resize -4<CR>")
nmap('<M-l>', "<Cmd>vertical resize +4<CR>")

nmap('<Space>', "<Cmd>nohlsearch<CR>")

-- move by display lines
nmap('j', "v:count ? 'j' : 'gj'", {expr = true})
nmap('k', "v:count ? 'k' : 'gk'", {expr = true})

-- move between windows
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-h>', '<C-w>h')
nmap('<C-l>', '<C-w>l')

-- manipulate tabs
nmap('<Leader>tn', "<Cmd>tabnew<CR>")
nmap('<Leader>tt', '<C-w>T') -- move window to a new tab

nmap('x', '"_x') -- x does not use register

-- toggle windows
nmap('<Leader>f', "<Cmd>Lexplore!<CR>")
nmap('<Leader>c', util.toggle_vimrc)
nmap('<Leader>q', util.toggle_quickfix)

-- autocorrect last spell error
imap('<C-s>', "<C-g>u<Esc>[S1z=`]a<C-g>u")
nmap('<C-s>', "[S1z=")

-- remove trailing whitespaces
nmap('<F12>', util.remove_trailing_spaces)

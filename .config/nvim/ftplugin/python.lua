local open_terminal = require('util').open_terminal
local run_python = function() open_terminal("python", true) end
local run_python_i = function() open_terminal("python -i", true) end

vim.keymap.set('n', '<F5>', run_python, { buffer = true })
vim.keymap.set('n', '<F6>', run_python_i, { buffer = true })

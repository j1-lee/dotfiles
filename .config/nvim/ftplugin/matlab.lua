vim.opt_local.tabstop = 4 -- # of visual spaces per tab
vim.opt_local.softtabstop = 4 -- # of spaces in tab when editing
vim.opt_local.shiftwidth = 4 -- # of spaces for indentation (when using >>)

local rx_start = [[\<classdef\>\|\<methods\>\|\<function\>\|\<if\>\|\<for\>\|\<while\>\|\<switch\>\|\<try\>]]
local rx_end = [[\(([^)]*\)\@<!\<end\>\([^(]*)\)\@!]]
vim.b.match_words = rx_start .. ':' .. rx_end

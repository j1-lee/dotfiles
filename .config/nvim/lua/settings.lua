vim.opt.encoding = 'utf-8'
vim.opt.fileformats = {'unix', 'dos'}
vim.opt.clipboard = 'unnamedplus'

vim.opt.expandtab = true -- tabs are spaces
vim.opt.tabstop = 2 -- # of visual spaces per tab
vim.opt.softtabstop = 2 -- # of spaces in tab when editing
vim.opt.shiftwidth = 2 -- # of spaces for indentation (when using >>)

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.scrolloff = 3 -- keep cursor away from screen border
vim.opt.whichwrap:append 'h,l' -- h and l move between lines

vim.opt.lazyredraw = true -- redraw only when necessary
vim.opt.showmode = false -- don't need -- INSERT --
vim.opt.title = true -- change title of terminal

vim.opt.list = true -- show unprintable chars
vim.opt.listchars = {tab = '• ', trail = '•', extends = '»', precedes = '«'}
vim.opt.fillchars = {fold = ' '} -- remove fold filling

vim.g.netrw_banner = 0 -- remove header in netrw
vim.g.netrw_winsize = 20 -- 20% width

vim.opt.wildoptions:remove 'pum' -- show suggestions horizontally (cmdline)
vim.opt.wildmode = {'longest:full', 'full'} -- behavior when <Tab> is pressed
vim.opt.pumheight = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

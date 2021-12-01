" vim-plug plugins -------------------------------------------------------------
call plug#begin()
" colorschemes
Plug 'arcticicestudio/nord-vim'
" status (or the like)
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
" editing
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
" filetype
Plug 'lervag/vimtex'
Plug 'j1-lee/vim-maki'
Plug 'jalvesaq/Nvim-R'
" LSP, completion, and snippet
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
" nvim-cmp sources
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-buffer'
call plug#end()

" auto-pairs settings ----------------------------------------------------------
let g:AutoPairsMultilineClose = 0

" lightline.vim settings -------------------------------------------------------
call j1#lightline#configure()

" nvim-lspconfig and nvim-cmp settings -----------------------------------------
lua require 'j1_lsp'

" nvim-r settings---------------------------------------------------------------
let g:R_assign_map = '<M-->'
let g:R_args = ['--no-save', '--no-restore', '--quiet']
let g:R_esc_term = 0
let g:r_syntax_fun_pattern = 1

" vim-vsnip settings -----------------------------------------------------------
imap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" vim-easy-align settings ------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-maki settings ------------------------------------------------------------
let g:maki_root = '~/Sync/wiki'
let g:maki_export = '~/Sync/wiki/Export'
nmap <silent> <Leader>w<Leader>w :exec 'MakiGo Journal/' . strftime('%F')<CR>
nmap <silent> <Leader>wi :MakiGo Journal<CR>

" vim-startify settings --------------------------------------------------------
let g:startify_bookmarks = [
      \ {'c': $MYVIMRC},
      \ {'w': '~/Sync/wiki/index.wiki'},
      \ {'d': '~/Sync/wiki/Journal.wiki'},
      \ ]
let g:startify_custom_header = []
nmap <silent> <Leader>s :Startify<CR>

" vimtex settings --------------------------------------------------------------
let g:vimtex_quickfix_mode = 0
let g:vimtex_toc_config = {
      \ 'show_help'   : 0,
      \ 'split_pos'   : 'vert rightbelow',
      \ 'split_width' : 25
      \ }

" basic ------------------------------------------------------------------------
set encoding=utf-8 fileformats=unix,dos
set clipboard=unnamedplus
set wildignorecase   " ignore case when completing file names
set inccommand=split " live substitution
set nojoinspaces     " add ' ' (not '  ') when joining lines

" color ------------------------------------------------------------------------
set termguicolors background=dark
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
colorscheme nord

" indentation ------------------------------------------------------------------
set expandtab     " tabs are spaces
set tabstop=2     " # of visual spaces per tab
set softtabstop=2 " # of spaces in tab when editing
set shiftwidth=2  " # of spaces for indentation (when using >>)
" re-indenting keeps visual selection
xmap > >gv
xmap < <gv

" appearance -------------------------------------------------------------------
set number relativenumber
set cursorline " highlight current line
set lazyredraw " redraw only when needed
set noshowmode " don't need -- INSERT --
set title      " change title of terminal
set list listchars=tab:•\ ,trail:•,extends:»,precedes:« " show unprintable chars
set fillchars=fold:\  " remove fold filling
let g:netrw_banner  = 0  " remove header of file explorer
let g:netrw_winsize = 20 " 20% width
" resize window
nmap <silent> <M-j> :resize -4<CR>
nmap <silent> <M-k> :resize +4<CR>
nmap <silent> <M-h> :vertical resize -4<CR>
nmap <silent> <M-l> :vertical resize +4<CR>

" completion -------------------------------------------------------------------
set wildoptions-=pum           " old-style horizontal suggestion (cmdline)
set wildmode=longest:full,full " behavior when <Tab> is pressed  (cmdline)
set pumheight=10

" search -----------------------------------------------------------------------
set ignorecase smartcase
nmap <silent> <Space> :nohlsearch<CR>

" navigation -------------------------------------------------------------------
set whichwrap+=<,>,h,l " h, l, left, right moves between lines
set scrolloff=3        " keep cursor away from the border
set splitbelow splitright
" j and k move by display lines
nnoremap <expr> j (v:count ? 'j' : 'gj')
nnoremap <expr> k (v:count ? 'k' : 'gk')
" move between windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
" jump between quickfix entries
nmap <silent> [q :call j1#mapfuncs#jump_qf('prev')<CR>
nmap <silent> ]q :call j1#mapfuncs#jump_qf('next')<CR>
nmap <silent> [Q :call j1#mapfuncs#jump_qf('first')<CR>
nmap <silent> ]Q :call j1#mapfuncs#jump_qf('last')<CR>
" new tab
nmap <Leader>tn :tabnew<CR>
nmap <Leader>tt <C-w>T
" Alt+BS deletes the last word (in insert and command)
map! <M-BS> <C-w>

" autocmds ---------------------------------------------------------------------
augroup init_vim
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType markdown,wiki setlocal spell spelllang+=cjk,es
  autocmd FileType python,sh,vim,snippets,matlab setlocal colorcolumn=81,82
  autocmd FileType vim setlocal foldmethod=marker
  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \ | exe 'normal! g`"' | endif " jump to last position when opening file
augroup END

" misc keymaps -----------------------------------------------------------------
" Y yanks till the line end
nmap Y y$
" x sends a char to the black hole
noremap x "_x
" toggle netrw, and config
nmap <silent> <Leader>f :Lexplore!<CR>
nmap <silent> <Leader>c :call j1#mapfuncs#toggle_vimrc()<CR>
nmap <silent> <Leader>q :call j1#mapfuncs#toggle_qf()<CR>
" autocorrect last spell error
imap <C-s> <C-g>u<Esc>[S1z=`]a<C-g>u
nmap <C-s> [S1z=
" disable Q
nmap Q <Nop>
" execute line/selection as vimscript
nmap <F9> :call j1#mapfuncs#run_vimscript(0)<CR>
xmap <F9> :<C-u>call j1#mapfuncs#run_vimscript(1)<CR>
" show the highlight group at the current position
nmap <F10> :echo 'Highlight:' synIDattr(synID(line('.'),col('.'),1),'name')
      \ '→' synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')<CR>
" remove trailing whitespaces
nmap <F12> :%s/\s\+$//e<CR>:nohl<CR>:echo 'Removed trailing whitespaces'<CR>

" commands ---------------------------------------------------------------------
command! CD cd %:p:h " cd to current dicretory
command! -bang Q q<bang> " no more annoying 'not an editor command Q'
command! -bang W w<bang>

" vim-plug plugins -------------------------------------------------------------
call plug#begin()
" colorschemes
Plug 'sainnhe/gruvbox-material'
" status (or the like)
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
" editing
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" languages
Plug 'dense-analysis/ale'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'lervag/vimtex'
Plug 'j1-lee/vim-maki'
call plug#end()

" auto-pairs settings ----------------------------------------------------------
let g:AutoPairsMultilineClose = 0

" deoplete.nvim settings -------------------------------------------------------
let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete,
      \ })
call deoplete#custom#option({
      \ 'ignore_case'   : v:true,
      \ 'smart_case'    : v:true,
      \ 'ignore_sources': {'_': ['ultisnips']}
      \ })

" lightline.vim settings -------------------------------------------------------
let g:lightline = {'colorscheme': 'gruvbox_material'}
let g:lightline.subseparator = {'left': '', 'right': ''}
let g:lightline.active = {
      \ 'left'  : [['mode'], ['filename', 'readonly', 'modified']],
      \ 'right' : [['lineinfo'], ['filetype'], ['errors', 'fileinfo']]
      \ }
let g:lightline.inactive = {
      \ 'left'  : [['filename']],
      \ 'right' : [['lineinfo']]
      \ }
let g:lightline.tabline = {'left': [['tabs']], 'right': []}
let g:lightline.tab = {'active': ['filename'], 'inactive': ['filename']}
let g:lightline.component = {
      \ 'mode'     : "%{winwidth(0) >= 40 ? lightline#mode() : ''}",
      \ 'readonly' : "%{&readonly && &modifiable ? '×' : ''}",
      \ 'modified' : "%{&modified ? '+' : ''}",
      \ 'filetype' : "%{winwidth(0) >= 40 ? &filetype : ''}",
      \ 'lineinfo' : "%l/%L%{
      \   winwidth(0) >= 40
      \     ? printf(' %3d%%', line('.') * 100 / line('$')) : ''
      \ }",
      \ 'fileinfo' : "%{
      \   (&fenc == 'utf-8' || &fenc == '') &&  &ff == 'unix'
      \     ? '' : &fileencoding . '[' . &fileformat . ']'
      \ }",
      \ 'errors'   : "%{
      \   index(['tex', 'python'], &filetype) >= 0
      \     ? get(GetFirstError(), 'status', '') : ''
      \ }",
      \ }

" ultisnips settings -----------------------------------------------------------
let g:UltiSnipsExpandTrigger       = '<Tab>'
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit           = 'vertical'

" vim-easy-align settings ------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-maki settings ------------------------------------------------------------
let g:maki_root = '~/Sync/wiki'
let g:maki_journal = '~/Sync/wiki/journal'
let g:maki_export = '~/Sync/wiki/export'

" vim-startify settings --------------------------------------------------------
let g:startify_bookmarks = [
      \ {'c': $MYVIMRC},
      \ {'w': '~/Sync/wiki/index.wiki'},
      \ {'d': '~/Sync/wiki/journal/index.wiki'},
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
let g:gruvbox_material_enable_italic = 1
colorscheme gruvbox-material

" indentation ------------------------------------------------------------------
set expandtab     " tabs are spaces
set tabstop=4     " # of visual spaces per tab
set softtabstop=4 " # of spaces in tab when editing
set shiftwidth=4  " # of spaces for indentation (when using >>)
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
let g:netrw_banner  = 0  " remove header of file explorer
let g:netrw_winsize = 20 " 20% width
" resize window
nmap <silent> <M-j> :resize -4<CR>
nmap <silent> <M-k> :resize +4<CR>
nmap <silent> <M-h> :vertical resize -4<CR>
nmap <silent> <M-l> :vertical resize +4<CR>

" completion -------------------------------------------------------------------
set wildoptions-=pum           " old-style horizontal wildmenu
set wildmode=longest:full,full " behavior when <Tab> is pressed
set completeopt=noinsert,menuone
" key mapping for next/previous/yes
inoremap <expr> <C-j> (pumvisible() ? "\<C-n>" : "\<C-j>")
inoremap <expr> <C-k> (pumvisible() ? "\<C-p>" : "\<C-k>")
inoremap <expr> <C-l> (pumvisible() ? "\<C-y>" : "\<C-l>")
" <CR> discards the suggestion
inoremap <expr> <CR> (pumvisible() ? "\<C-e>\<CR>" : "\<CR>")

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
nmap <silent> [q :QuickFixJump prev<CR>
nmap <silent> ]q :QuickFixJump next<CR>
nmap <silent> [Q :QuickFixJump first<CR>
nmap <silent> ]Q :QuickFixJump last<CR>
" new tab
nmap <Leader>tn :tabnew<CR>
nmap <Leader>tt <C-w>T
" Alt+BS deletes the last word (in insert and command)
map! <M-BS> <C-w>

" autocmds ---------------------------------------------------------------------
augroup init_vim
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd FileType sh,vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType markdown,wiki setlocal spell spelllang+=cjk,es
  autocmd FileType python,sh,vim,snippets,matlab setlocal colorcolumn=81,82,83
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
" remove trailing whitespaces
nmap <F12> :%s/\s\+$//e<CR>:nohl<CR>:echo 'Removed trailing whitespaces'<CR>
" toggle netrw, and config
nmap <silent> <Leader>f :Lexplore!<CR>
nmap <silent> <Leader>c :call ToggleVimrc()<CR>
nmap <silent> <Leader>q :call ToggleQuickFix()<CR>
" autocorrect last spell error
imap <C-c> <C-g>u<Esc>[S1z=`]a<C-g>u
nmap <C-c> [S1z=
" disable Q
nmap Q <Nop>
" show the highlight group at the current position
nmap <F10> :echo 'Highlight:' synIDattr(synID(line('.'),col('.'),1),'name')<CR>

" commands ---------------------------------------------------------------------
command! CD cd %:p:h " cd to current dicretory
command! -bang Q q<bang> " no more annoying 'not an editor command Q'
command! -nargs=1 QuickFixJump
      \ try | c<args> | catch /E553/ | cc | catch /E42/ | endtry

" functions --------------------------------------------------------------------
" toggle vimrc
function! ToggleVimrc()
  for b in tabpagebuflist()
    if expand('#' . b . ':t') ==# fnamemodify($MYVIMRC, ':t')
      execute 'bdelete' b
      return
    endif
  endfor
  if len(tabpagebuflist()) == 1 && bufname() == '' && !&modified
    execute 'edit' $MYVIMRC
    return
  endif
  execute 'vsplit' $MYVIMRC
endfunction

" toggle quickfix
function! ToggleQuickFix()
  for b in tabpagebuflist()
    if getbufvar(b, '&buftype') == 'quickfix'
      execute len(tabpagebuflist()) == 1 ? 'enew' : 'cclose'
      return
    endif
  endfor
  copen
endfunction

" return first error/warning (latter if no error exists)
function! GetFirstError(...)
  let l:filter = 'v:val.bufnr == bufnr()'
  if a:0 | let l:filter .= '&& v:val.lnum == a:1' | endif
  let l:list = filter(getqflist() + getloclist(0), l:filter)
  for l:type in ['E', 'W']
    let l:err = get(filter(copy(l:list), 'v:val.type == l:type'), 0, {})
    if !empty(l:err)
      let l:err.status = l:err.type . ':' . l:err.lnum
      break
    endif
  endfor
  return l:err
endfunction
